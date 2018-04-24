//License: https://github.com/mxcl/PromiseKit/blob/master/LICENSE
import Foundation
import Dispatch
import class Dispatch.DispatchQueue
import class Foundation.NSError
import func Foundation.NSLog
import class Foundation.Thread
import struct Foundation.TimeInterval
import Foundation.NSProgress

let PMKErrorDomain:String = "PromiseKit"

let PMKFailingPromiseIndexKey:String = "PMKFailingPromiseIndexKey"
let PMKJoinPromisesKey:String = "PMKJoinPromisesKey"

let PMKUnexpectedError:Int = 1
let PMKInvalidUsageError:Int =  3
let PMKAccessDeniedError:Int =  4
let PMKOperationCancelled:Int =  5
let PMKOperationFailed:Int =  8
let PMKTaskError:Int =  9
let PMKJoinError:Int =  10



/**
     after(.seconds(2)).then {
         //…
     }

- Returns: A new promise that fulfills after the specified duration.
*/
public func after(seconds: TimeInterval) -> Guarantee<Void> {
    let (rg, seal) = Guarantee<Void>.pending()
    let when = DispatchTime.now() + seconds
#if swift(>=4.0)
    DispatchQueue.global().asyncAfter(deadline: when) { seal(()) }
#else
    DispatchQueue.global().asyncAfter(deadline: when, execute: seal)
#endif
    return rg
}

/**
     after(seconds: 1.5).then {
         //…
     }

 - Returns: A new promise that fulfills after the specified duration.
*/
public func after(_ interval: DispatchTimeInterval) -> Guarantee<Void> {
    let (rg, seal) = Guarantee<Void>.pending()
    let when = DispatchTime.now() + interval
#if swift(>=4.0)
    DispatchQueue.global().asyncAfter(deadline: when) { seal(()) }
#else
    DispatchQueue.global().asyncAfter(deadline: when, execute: seal)
#endif
    return rg
}

/**
 AnyPromise is an Objective-C compatible promise.
*/
@objc(AnyPromise) public class AnyPromise: NSObject, Thenable, CatchMixin {
    fileprivate let box: Box<Any?>

    /// - Returns: A new `AnyPromise` bound to a `Promise<Any>`.
    public init<U: Thenable>(_ bridge: U) {
        box = EmptyBox()
        super.init()
        bridge.pipe {
            switch $0 {
            case .rejected(let error):
                self.box.seal(error)
            case .fulfilled(let value):
                self.box.seal(value)
            }
        }
    }

    fileprivate init(box: Box<Any?>) {
        self.box = box
    }

    public func pipe(to body: @escaping (Result<Any?>) -> Void) {
        sewer {
            switch $0 {
            case .fulfilled:
                // calling through to the ObjC `value` property unwraps (any) PMKManifold
                body(.fulfilled(self.value(forKey: "value")))
            case .rejected:
                body($0)
            }
        }
    }

    public var result: Result<Any?>? {
        switch box.inspect() {
        case .pending:
            return nil
        case .resolved(let obj as Error):
            return .rejected(obj)
        case .resolved(let value):
            return .fulfilled(value)
        }
    }

    fileprivate func sewer(to body: @escaping (Result<Any?>) -> Void) {
        switch box.inspect() {
        case .pending:
            box.inspect {
                switch $0 {
                case .pending(let handlers):
                    handlers.append {
                        if let error = $0 as? Error {
                            body(.rejected(error))
                        } else {
                            body(.fulfilled($0))
                        }
                    }
                case .resolved(let error as Error):
                    body(.rejected(error))
                case .resolved(let value):
                    body(.fulfilled(value))
                }
            }
        case .resolved(let error as Error):
            body(.rejected(error))
        case .resolved(let value):
            body(.fulfilled(value))
        }
    }
}

internal extension AnyPromise {
    @objc private var __value: Any? {
        switch box.inspect() {
        case .pending:
            return nil
        case .resolved(let obj):
            return obj
        }
    }

    @objc private var __pending: Bool {
        switch box.inspect() {
        case .pending:
            return true
        case .resolved:
            return false
        }
    }

    /**
     Creates a resolved promise.

     When developing your own promise systems, it is occasionally useful to be able to return an already resolved promise.

     - Parameter value: The value with which to resolve this promise. Passing an `NSError` will cause the promise to be rejected, passing an AnyPromise will return a new AnyPromise bound to that promise, otherwise the promise will be fulfilled with the value passed.

     - Returns: A resolved promise.
     */
    @objc class func promiseWithValue(_ value: Any?) -> AnyPromise {
        switch value {
        case let promise as AnyPromise:
            return promise
        default:
            return AnyPromise(box: SealedBox(value: value))
        }
    }

    /**
     Create a new promise that resolves with the provided block.

     Use this method when wrapping asynchronous code that does *not* use promises so that this code can be used in promise chains.

     If `resolve` is called with an `NSError` object, the promise is rejected, otherwise the promise is fulfilled.

     Don’t use this method if you already have promises! Instead, just return your promise.

     Should you need to fulfill a promise but have no sensical value to use: your promise is a `void` promise: fulfill with `nil`.

     The block you pass is executed immediately on the calling thread.

     - Parameter block: The provided block is immediately executed, inside the block call `resolve` to resolve this promise and cause any attached handlers to execute. If you are wrapping a delegate-based system, we recommend instead to use: initWithResolver:

     - Returns: A new promise.
     - Warning: Resolving a promise with `nil` fulfills it.
     - SeeAlso: http://promisekit.org/sealing-your-own-promises/
     - SeeAlso: http://promisekit.org/wrapping-delegation/
     */
    @objc class func promiseWithResolverBlock(_ body: (@escaping (Any?) -> Void) -> Void) -> AnyPromise {
        let box = EmptyBox<Any?>()
        let rap = AnyPromise(box: box)
        body { AnyPromise.apply($0, box) }
        return rap
    }

    private static func apply(_ value: Any?, _ box: Box<Any?>) {
        switch value {
        case let p as AnyPromise:
            p.__pipe{ apply($0, box) }
        default:
            box.seal(value)
        }
    }

    @objc private func __thenOn(_ q: DispatchQueue, execute body: @escaping (Any?) -> Any?) -> AnyPromise {
        let box = EmptyBox<Any?>()
        let rap = AnyPromise(box: box)
        ___pipe {
            switch $0 {
            case .rejected(let error):
                box.seal(error)
            case .fulfilled(let value):
                q.async {
                    AnyPromise.apply(body(value), box)
                }
            }
        }
        return rap

    }

    @objc private func __catchOn(_ q: DispatchQueue, execute body: @escaping (Any?) -> Any?) -> AnyPromise {
        let box = EmptyBox<Any?>()
        let rap = AnyPromise(box: box)
        ___pipe {
            switch $0 {
            case .rejected(let error):
                q.async {
                    AnyPromise.apply(body(error), box)
                }
            case .fulfilled(let value):
                box.seal(value)
            }
        }
        return rap
    }

    @objc private func __alwaysOn(_ q: DispatchQueue, execute body: @escaping () -> Void) -> AnyPromise {
        let box = EmptyBox<Any?>()
        let rap = AnyPromise(box: box)
        __pipe { obj in
            q.async {
                body()
                box.seal(obj)
            }
        }
        return rap
    }

    /// converts NSErrors, feeds raw PMKManifolds
    /// exposed to ObjC for use in a few places
    @objc private func __pipe(_ body: @escaping (Any?) -> Void) {
        sewer {
            switch $0 {
            case .fulfilled(let value):
                body(value)
            case .rejected(let error):
                body(error as NSError)
            }
        }
    }

    /// converts NSErrors, feeds raw PMKManifolds
    private func ___pipe(to body: @escaping (Result<Any?>) -> Void) {
        sewer {
            switch $0 {
            case .fulfilled:
                body($0)
            case .rejected(let error):
                body(.rejected(error as NSError))
            }
        }
    }
}


extension AnyPromise {
    /// - Returns: A description of the state of this promise.
    override public var description: String {
        switch box.inspect() {
        case .pending:
            return "AnyPromise(…)"
        case .resolved(let obj?):
            return "AnyPromise(\(obj))"
        case .resolved(nil):
            return "AnyPromise(nil)"
        }
    }
}


#if swift(>=3.1)
public extension Promise where T == Any? {
    convenience init(_ anyPromise: AnyPromise) {
        self.init(.pending) {
            anyPromise.pipe(to: $0.resolve)
        }
    }
}
#else
extension AnyPromise {
    public func asPromise() -> Promise<Any?> {
        return Promise(.pending, resolver: { resolve in
            pipe { result in
                switch result {
                case .rejected(let error):
                    resolve.reject(error)
                case .fulfilled(let obj):
                    resolve.fulfill(obj)
                }
            }
        })
    }
}
#endif

enum Sealant<R> {
    case pending(Handlers<R>)
    case resolved(R)
}

class Handlers<R> {
    var bodies: [(R) -> Void] = []
    func append(_ item: @escaping(R) -> Void) { bodies.append(item) }
}

class Box<T> {
    func inspect() -> Sealant<T> { fatalError() }
    func inspect(_: (Sealant<T>) -> Void) { fatalError() }
    func seal(_: T) {}
}

class SealedBox<T>: Box<T> {
    let value: T

    init(value: T) {
        self.value = value
    }

    override func inspect() -> Sealant<T> {
        return .resolved(value)
    }
}

class EmptyBox<T>: Box<T> {
    private var sealant = Sealant<T>.pending(.init())
    private let barrier = DispatchQueue(label: "org.promisekit.barrier", attributes: .concurrent)

    override func seal(_ value: T) {
        var handlers: Handlers<T>!
        barrier.sync(flags: .barrier) {
            guard case .pending(let _handlers) = self.sealant else {
                return  // already fulfilled!
            }
            handlers = _handlers
            self.sealant = .resolved(value)
        }

        //FIXME we are resolved so should `pipe(to:)` be called at this instant, “thens are called in order” would be invalid
        //NOTE we don’t do this in the above `sync` because that could potentially deadlock
        //THOUGH since `then` etc. typically invoke after a run-loop cycle, this issue is somewhat less severe

        if let handlers = handlers {
            handlers.bodies.forEach{ $0(value) }
        }

        //TODO solution is an unfortunate third state “sealed” where then's get added
        // to a separate handler pool for that state
        // any other solution has potential races
    }

    override func inspect() -> Sealant<T> {
        var rv: Sealant<T>!
        barrier.sync {
            rv = self.sealant
        }
        return rv
    }

    override func inspect(_ body: (Sealant<T>) -> Void) {
        var sealed = false
        barrier.sync(flags: .barrier) {
            switch sealant {
            case .pending:
                // body will append to handlers, so we must stay barrier’d
                body(sealant)
            case .resolved:
                sealed = true
            }
        }
        if sealed {
            // we do this outside the barrier to prevent potential deadlocks
            // it's safe because we never transition away from this state
            body(sealant)
        }
    }
}


extension Optional where Wrapped: DispatchQueue {
    func async(_ body: @escaping() -> Void) {
        switch self {
        case .none:
            body()
        case .some(let q):
            q.async(execute: body)
        }
    }
}

public protocol CatchMixin: Thenable
{}

public extension CatchMixin {
    @discardableResult
    func `catch`(on: DispatchQueue? = conf.Q.return, policy: CatchPolicy = conf.catchPolicy, _ body: @escaping(Error) -> Void) -> PMKFinalizer {
        let finalizer = PMKFinalizer()
        pipe {
            switch $0 {
            case .rejected(let error):
                guard policy == .allErrors || !error.isCancelled else {
                    fallthrough
                }
                on.async {
                    body(error)
                    finalizer.pending.resolve(())
                }
            case .fulfilled:
                finalizer.pending.resolve(())
            }
        }
        return finalizer
    }
}

public class PMKFinalizer {
    let pending = Guarantee<Void>.pending()

    public func finally(_ body: @escaping () -> Void) {
        pending.guarantee.done(body)
    }
}


public extension CatchMixin {
    func recover<U: Thenable>(on: DispatchQueue? = conf.Q.map, policy: CatchPolicy = conf.catchPolicy, _ body: @escaping(Error) throws -> U) -> Promise<T> where U.T == T {
        let rp = Promise<U.T>(.pending)
        pipe {
            switch $0 {
            case .fulfilled(let value):
                rp.box.seal(.fulfilled(value))
            case .rejected(let error):
                if policy == .allErrors || !error.isCancelled {
                    on.async {
                        do {
                            let rv = try body(error)
                            guard rv !== rp else { throw PMKError.returnedSelf }
                            rv.pipe(to: rp.box.seal)
                        } catch {
                            rp.box.seal(.rejected(error))
                        }
                    }
                } else {
                    rp.box.seal(.rejected(error))
                }
            }
        }
        return rp
    }

    /// recover into a Guarantee, note it is logically impossible for this to take a catchPolicy, thus allErrors are handled
    @discardableResult
    func recover(on: DispatchQueue? = conf.Q.map, _ body: @escaping(Error) -> Guarantee<T>) -> Guarantee<T> {
        let rg = Guarantee<T>(.pending)
        pipe {
            switch $0 {
            case .fulfilled(let value):
                rg.box.seal(value)
            case .rejected(let error):
                on.async {
                    body(error).pipe(to: rg.box.seal)
                }
            }
        }
        return rg
    }

    func ensure(on: DispatchQueue? = conf.Q.return, _ body: @escaping () -> Void) -> Promise<T> {
        let rp = Promise<T>(.pending)
        pipe { result in
            on.async {
                body()
                rp.box.seal(result)
            }
        }
        return rp
    }

    func cauterize() {
        self.catch {
            print("PromiseKit:cauterized-error:", $0)
        }
    }
}


public extension CatchMixin where T == Void {
    @discardableResult
    func recover(on: DispatchQueue? = conf.Q.map, _ body: @escaping(Error) -> Void) -> Guarantee<Void> {
        let rg = Guarantee<Void>(.pending)
        pipe {
            switch $0 {
            case .fulfilled:
                rg.box.seal(())
            case .rejected(let error):
                on.async {
                    body(error)
                    rg.box.seal(())
                }
            }
        }
        return rg
    }

    func recover(on: DispatchQueue? = conf.Q.map, _ body: @escaping(Error) throws -> Void) -> Promise<Void> {
        let rg = Promise<Void>(.pending)
        pipe {
            switch $0 {
            case .fulfilled:
                rg.box.seal(.fulfilled(()))
            case .rejected(let error):
                on.async {
                    do {
                        rg.box.seal(.fulfilled(try body(error)))
                    } catch {
                        rg.box.seal(.rejected(error))
                    }
                }
            }
        }
        return rg
    }
}

public struct PMKConfiguration {
    /// the default queues that promises handlers dispatch to
    public var Q = (map: DispatchQueue.main, return: DispatchQueue.main)

    public var catchPolicy = CatchPolicy.allErrorsExceptCancellation
}

public var conf = PMKConfiguration()

extension Promise: CustomStringConvertible {
    public var description: String {
        switch result {
        case nil:
            return "Promise(…\(T.self))"
        case .rejected(let error)?:
            return "Promise(\(error))"
        case .fulfilled(let value)?:
            return "Promise(\(value))"
        }
    }
}

extension Promise: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch box.inspect() {
        case .pending(let handlers):
            return "Promise<\(T.self)>.pending(handlers: \(handlers.bodies.count))"
        case .resolved(.rejected(let error)):
            return "Promise<\(T.self)>.rejected(\(type(of: error)).\(error))"
        case .resolved(.fulfilled(let value)):
            return "Promise<\(T.self)>.fulfilled(\(value))"
        }
    }
}

public enum PMKError: Error {
    /**
     The completionHandler with form (T?, ErrorType?) was called with (nil, nil)
     This is invalid as per Cocoa/Apple calling conventions.
     */
    case invalidCallingConvention

    /**
     A handler returned its own promise. 99% of the time, this is likely a 
     programming error. It is also invalid per Promises/A+.
     */
    case returnedSelf

    /** `when()`, `race()` etc. were called with invalid parameters, eg. an empty array. */
    case badInput

    /// The operation was cancelled
    case cancelled

    /// `nil` was returned from `flatMap`
    case flatMap(Any, Any.Type)
}

extension PMKError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .flatMap(let obj, let type):
            return "Could not `flatMap<\(type)>`: \(obj)"
        case .invalidCallingConvention:
            return "A closure was called with an invalid calling convention, probably (nil, nil)"
        case .returnedSelf:
            return "A promise handler returned itself"
        case .badInput:
            return "Bad input was provided to a PromiseKit function"
        case .cancelled:
            return "The asynchronous sequence was cancelled"
        }
    }
}

extension PMKError: LocalizedError {
    public var errorDescription: String? {
        return debugDescription
    }
}



public protocol CancellableError: Error {
    var isCancelled: Bool { get }
}

extension Error {
    public var isCancelled: Bool {
        do {
            throw self
        } catch PMKError.cancelled {
            return true
        } catch let error as CancellableError {
            return error.isCancelled
        } catch URLError.cancelled {
            return true
        } catch CocoaError.userCancelled {
            return true
        } catch {
            return false
        }
    }
}

public enum CatchPolicy {
    case allErrors
    case allErrorsExceptCancellation
}

/**
 Judicious use of `firstly` *may* make chains more readable.

 Compare:

     URLSession.shared.dataTask(url: url1).then {
         URLSession.shared.dataTask(url: url2)
     }.then {
         URLSession.shared.dataTask(url: url3)
     }

 With:

     firstly {
         URLSession.shared.dataTask(url: url1)
     }.then {
         URLSession.shared.dataTask(url: url2)
     }.then {
         URLSession.shared.dataTask(url: url3)
     }
 */
public func firstly<U: Thenable>(execute body: () throws -> U) -> Promise<U.T> {
    do {
        let rp = Promise<U.T>(.pending)
        try body().pipe(to: rp.box.seal)
        return rp
    } catch {
        return Promise(error: error)
    }
}

public func firstly<T>(execute body: () -> Guarantee<T>) -> Guarantee<T> {
    return body()
}

public class Guarantee<T>: Thenable {
    let box: Box<T>

    public init(value: T) {
        box = SealedBox(value: value)
    }

    public init(_: PMKUnambiguousInitializer, resolver body: (@escaping(T) -> Void) -> Void) {
        box = EmptyBox()
        body(box.seal)
    }

    public func pipe(to: @escaping(Result<T>) -> Void) {
        pipe{ to(.fulfilled($0)) }
    }

    func pipe(to: @escaping(T) -> Void) {
        switch box.inspect() {
        case .pending:
            box.inspect {
                switch $0 {
                case .pending(let handlers):
                    handlers.append(to)
                case .resolved(let value):
                    to(value)
                }
            }
        case .resolved(let value):
            to(value)
        }
    }

    public var result: Result<T>? {
        switch box.inspect() {
        case .pending:
            return nil
        case .resolved(let value):
            return .fulfilled(value)
        }
    }

    init(_: PMKUnambiguousInitializer) {
        box = EmptyBox()
    }

    public class func pending() -> (guarantee: Guarantee<T>, resolve: (T) -> Void) {
        return { ($0, $0.box.seal) }(Guarantee<T>(.pending))
    }
}

public extension Guarantee {
    @discardableResult
    func done(on: DispatchQueue? = conf.Q.return, _ body: @escaping(T) -> Void) -> Guarantee<Void> {
        let rg = Guarantee<Void>(.pending)
        pipe { (value: T) in
            on.async {
                body(value)
                rg.box.seal(())
            }
        }
        return rg
    }

    func map<U>(on: DispatchQueue? = conf.Q.map, _ body: @escaping(T) -> U) -> Guarantee<U> {
        let rg = Guarantee<U>(.pending)
        pipe { value in
            on.async {
                rg.box.seal(body(value))
            }
        }
        return rg
    }

	@discardableResult
    func then<U>(on: DispatchQueue? = conf.Q.map, _ body: @escaping(T) -> Guarantee<U>) -> Guarantee<U> {
        let rg = Guarantee<U>(.pending)
        pipe { value in
            on.async {
                body(value).pipe(to: rg.box.seal)
            }
        }
        return rg
    }

    public func asVoid() -> Guarantee<Void> {
        return map(on: nil) { _ in }
    }
    
    /**
     Blocks this thread, so you know, don’t call this on a serial thread that
     any part of your chain may use. Like the main thread for example.
     */
    public func wait() -> T {

        if Thread.isMainThread {
            print("PromiseKit: warning: `wait()` called on main thread!")
        }

        var result = value

        if result == nil {
            let group = DispatchGroup()
            group.enter()
            pipe { (foo: T) in result = foo; group.leave() }
            group.wait()
        }
        
        return result!
    }
}

#if swift(>=3.1)
public extension Guarantee where T == Void {
    convenience init() {
        self.init(value: Void())
    }
}
#endif


public extension DispatchQueue {
    /**
     Asynchronously executes the provided closure on a dispatch queue.

         DispatchQueue.global().async(.promise) {
             md5(input)
         }.done { md5 in
             //…
         }

     - Parameter body: The closure that resolves this promise.
     - Returns: A new `Guarantee` resolved by the result of the provided closure.
     - Note: There is no Promise/Thenable version of this due to Swift compiler ambiguity issues.
     */
    final func async<T>(_: PMKNamespacer, group: DispatchGroup? = nil, qos: DispatchQoS = .default, flags: DispatchWorkItemFlags = [], execute body: @escaping () -> T) -> Guarantee<T> {
        let rg = Guarantee<T>(.pending)
        async(group: group, qos: qos, flags: flags) {
            rg.box.seal(body())
        }
        return rg
    }
}

/**
 Suspends the active thread waiting on the provided promise.

 Useful when an application's main thread should not terminate before the promise is resolved
 (e.g. commandline applications).

 - Returns: The value of the provided promise once resolved.
 - Throws: An error, should the promise be resolved with an error.
 - SeeAlso: `wait()`
*/
public func hang<T>(_ promise: Promise<T>) throws -> T {
#if os(Linux)
    // isMainThread is not yet implemented on Linux.
    let runLoopModeRaw = RunLoopMode.defaultRunLoopMode.rawValue._bridgeToObjectiveC()
    let runLoopMode: CFString = unsafeBitCast(runLoopModeRaw, to: CFString.self)
#else
    guard Thread.isMainThread else {
        // hang doesn't make sense on threads that aren't the main thread.
        // use `.wait()` on those threads.
        fatalError("Only call hang() on the main thread.")
    }
    let runLoopMode: CFRunLoopMode = CFRunLoopMode.defaultMode
#endif

    if promise.isPending {
        var context = CFRunLoopSourceContext()
        let runLoop = CFRunLoopGetCurrent()
        let runLoopSource = CFRunLoopSourceCreate(nil, 0, &context)
        CFRunLoopAddSource(runLoop, runLoopSource, runLoopMode)

        _ = promise.ensure {
            CFRunLoopStop(runLoop)
        }

        while promise.isPending {
            CFRunLoopRun()
        }
        CFRunLoopRemoveSource(runLoop, runLoopSource, runLoopMode)
    }

    switch promise.result! {
    case .rejected(let error):
        throw error
    case .fulfilled(let value):
        return value
    }
}

public class Promise<T>: Thenable, CatchMixin {
    let box: Box<Result<T>>

    public init(value: T) {
        box = SealedBox(value: .fulfilled(value))
    }

    public init(error: Error) {
        box = SealedBox(value: .rejected(error))
    }

    public init<U: Thenable>(_ bridge: U) where U.T == T {
        box = EmptyBox()
        bridge.pipe(to: box.seal)
    }

    public init(_: PMKUnambiguousInitializer, resolver body: (Resolver<T>) throws -> Void) {
        box = EmptyBox()
        do {
            try body(Resolver(box))
        } catch {
            box.seal(.rejected(error))
        }
    }

    public class func pending() -> (promise: Promise<T>, resolver: Resolver<T>) {
        return { ($0, Resolver($0.box)) }(Promise<T>(.pending))
    }

    public func pipe(to: @escaping(Result<T>) -> Void) {
        switch box.inspect() {
        case .pending:
            box.inspect {
                switch $0 {
                case .pending(let handlers):
                    handlers.append(to)
                case .resolved(let value):
                    to(value)
                }
            }
        case .resolved(let value):
            to(value)
        }
    }

    public var result: Result<T>? {
        switch box.inspect() {
        case .pending:
            return nil
        case .resolved(let result):
            return result
        }
    }

    init(_: PMKUnambiguousInitializer) {
        box = EmptyBox()
    }
}

public extension Promise {
    func tap(_ body: @escaping(Result<T>) -> Void) -> Promise {
        pipe(to: body)
        return self
    }

    public func asVoid() -> Promise<Void> {
        return map(on: nil) { _ in }
    }
    
    /**
     Blocks this thread, so you know, don’t call this on a serial thread that
     any part of your chain may use. Like the main thread for example.
     */
    public func wait() throws -> T {

        if Thread.isMainThread {
            print("PromiseKit: warning: `wait()` called on main thread!")
        }

        var result = self.result

        if result == nil {
            let group = DispatchGroup()
            group.enter()
            pipe { result = $0; group.leave() }
            group.wait()
        }

        switch result! {
        case .rejected(let error):
            throw error
        case .fulfilled(let value):
            return value
        }
    }
}

#if swift(>=3.1)
extension Promise where T == Void {
    public convenience init() {
        self.init(value: Void())
    }
}
#endif


public extension DispatchQueue {
    /**
     Asynchronously executes the provided closure on a dispatch queue.

         DispatchQueue.global().async(.promise) {
             try md5(input)
         }.done { md5 in
             //…
         }

     - Parameter body: The closure that resolves this promise.
     - Returns: A new `Promise` resolved by the result of the provided closure.
     - Note: There is no Promise/Thenable version of this due to Swift compiler ambiguity issues.
     */
    final func async<T>(_: PMKNamespacer, group: DispatchGroup? = nil, qos: DispatchQoS = .default, flags: DispatchWorkItemFlags = [], execute body: @escaping () throws -> T) -> Promise<T> {
        let promise = Promise<T>(.pending)
        async(group: group, qos: qos, flags: flags) {
            do {
                promise.box.seal(.fulfilled(try body()))
            } catch {
                promise.box.seal(.rejected(error))
            }
        }
        return promise
    }
}


public enum PMKNamespacer {
    case promise
}

public enum PMKUnambiguousInitializer {
    case pending
}
@inline(__always)
private func _race<U: Thenable>(_ thenables: [U]) -> Promise<U.T> {
    let rp = Promise<U.T>(.pending)
    for thenable in thenables {
        thenable.pipe(to: rp.box.seal)
    }
    return rp
}

/**
 Resolves with the first resolving promise from a set of promises.

     race(promise1, promise2, promise3).then { winner in
         //…
     }

 - Returns: A new promise that resolves when the first promise in the provided promises resolves.
 - Warning: If any of the provided promises reject, the returned promise is rejected.
 - Warning: aborts if the array is empty.
*/
public func race<U: Thenable>(_ thenables: U...) -> Promise<U.T> {
    return _race(thenables)
}

/**
 Resolves with the first resolving promise from a set of promises.

     race(promise1, promise2, promise3).then { winner in
         //…
     }

 - Returns: A new promise that resolves when the first promise in the provided promises resolves.
 - Warning: If any of the provided promises reject, the returned promise is rejected.
 - Remark: Returns promise rejected with PMKError.badInput if empty array provided
*/
public func race<U: Thenable>(_ thenables: [U]) -> Promise<U.T> {
    guard !thenables.isEmpty else {
        return Promise(error: PMKError.badInput)
    }
    return _race(thenables)
}

/**
 Resolves with the first resolving Guarantee from a set of promises.

     race(promise1, promise2, promise3).then { winner in
         //…
     }

 - Returns: A new guarantee that resolves when the first promise in the provided promises resolves.
 - Warning: If any of the provided promises reject, the returned promise is rejected.
 - Remark: Returns promise rejected with PMKError.badInput if empty array provided
*/
public func race<T>(_ guarantees: Guarantee<T>...) -> Guarantee<T> {
    let rg = Guarantee<T>(.pending)
    for guarantee in guarantees {
        guarantee.pipe(to: rg.box.seal)
    }
    return rg
}
public class Resolver<T> {
    let box: Box<Result<T>>

    init(_ box: Box<Result<T>>) {
        self.box = box
    }

    deinit {
        if case .pending = box.inspect() {
            print("PromiseKit: warning: pending promise deallocated")
        }
    }
}

public extension Resolver {
    func fulfill(_ value: T) {
        box.seal(.fulfilled(value))
    }

    func reject(_ error: Error) {
        box.seal(.rejected(error))
    }

    public func resolve(_ result: Result<T>) {
        box.seal(result)
    }

    public func resolve(_ obj: T?, _ error: Error?) {
        if let error = error {
            reject(error)
        } else if let obj = obj {
            fulfill(obj)
        } else {
            reject(PMKError.invalidCallingConvention)
        }
    }

    public func resolve(_ obj: T, _ error: Error?) {
        if let error = error {
            reject(error)
        } else {
            fulfill(obj)
        }
    }

    public func resolve(_ error: Error?, _ obj: T?) {
        resolve(obj, error)
    }
}

#if swift(>=3.1)
extension Resolver where T == Void {
    public func resolve(_ error: Error?) {
        if let error = error {
            reject(error)
        } else {
            fulfill(())
        }
    }
}
#endif

public enum Result<T> {
    case fulfilled(T)
    case rejected(Error)
}

public extension Result {
    var isFulfilled: Bool {
        switch self {
        case .fulfilled:
            return true
        case .rejected:
            return false
        }
    }
}




public protocol Thenable: class {
    associatedtype T
    func pipe(to: @escaping(Result<T>) -> Void)
    var result: Result<T>? { get }
}

public extension Thenable {
    public func then<U: Thenable>(on: DispatchQueue? = conf.Q.map, file: StaticString = #file, line: UInt = #line, _ body: @escaping(T) throws -> U) -> Promise<U.T> {
        let rp = Promise<U.T>(.pending)
        pipe {
            switch $0 {
            case .fulfilled(let value):
                on.async {
                    do {
                        let rv = try body(value)
                        guard rv !== rp else { throw PMKError.returnedSelf }
                        rv.pipe(to: rp.box.seal)
                    } catch {
                        rp.box.seal(.rejected(error))
                    }
                }
            case .rejected(let error):
                rp.box.seal(.rejected(error))
            }
        }
        return rp
    }

    func map<U>(on: DispatchQueue? = conf.Q.map, _ transform: @escaping(T) throws -> U) -> Promise<U> {
        let rp = Promise<U>(.pending)
        pipe {
            switch $0 {
            case .fulfilled(let value):
                on.async {
                    do {
                        rp.box.seal(.fulfilled(try transform(value)))
                    } catch {
                        rp.box.seal(.rejected(error))
                    }
                }
            case .rejected(let error):
                rp.box.seal(.rejected(error))
            }
        }
        return rp
    }

    func flatMap<U>(on: DispatchQueue? = conf.Q.map, _ transform: @escaping(T) throws -> U?) -> Promise<U> {
        let rp = Promise<U>(.pending)
        pipe {
            switch $0 {
            case .fulfilled(let value):
                on.async {
                    do {
                        if let rv = try transform(value) {
                            rp.box.seal(.fulfilled(rv))
                        } else {
                            throw PMKError.flatMap(value, U.self)
                        }
                    } catch {
                        rp.box.seal(.rejected(error))
                    }
                }
            case .rejected(let error):
                rp.box.seal(.rejected(error))
            }
        }
        return rp
    }

    func done(on: DispatchQueue? = conf.Q.return, _ body: @escaping(T) throws -> Void) -> Promise<Void> {
        let rp = Promise<Void>(.pending)
        pipe {
            switch $0 {
            case .fulfilled(let value):
                on.async {
                    do {
                        try body(value)
                        rp.box.seal(.fulfilled(()))
                    } catch {
                        rp.box.seal(.rejected(error))
                    }
                }
            case .rejected(let error):
                rp.box.seal(.rejected(error))
            }
        }
        return rp
    }

    /// Immutably access the fulfilled value; the returned Promise maintains that value.
    func get(_ body: @escaping (T) throws -> Void) -> Promise<T> {
        return map(on: conf.Q.return) {
            try body($0)
            return $0
        }
    }

    public func asVoid() -> Promise<Void> {
        return map(on: nil) { _ in }
    }
}

public extension Thenable {
    /**
     - Returns: The error with which this promise was rejected; `nil` if this promise is not rejected.
     */
    var error: Error? {
        switch result {
        case .none:
            return nil
        case .some(.fulfilled):
            return nil
        case .some(.rejected(let error)):
            return error
        }
    }

    /**
     - Returns: `true` if the promise has not yet resolved.
     */
    var isPending: Bool {
        return result == nil
    }

    /**
     - Returns: `true` if the promise has resolved.
     */
    var isResolved: Bool {
        return !isPending
    }

    /**
     - Returns: `true` if the promise was fulfilled.
     */
    var isFulfilled: Bool {
        return value != nil
    }

    /**
     - Returns: `true` if the promise was rejected.
     */
    var isRejected: Bool {
        return error != nil
    }

    /**
     - Returns: The value with which this promise was fulfilled or `nil` if this promise is pending or rejected.
     */
    var value: T? {
        switch result {
        case .none:
            return nil
        case .some(.fulfilled(let value)):
            return value
        case .some(.rejected):
            return nil
        }
    }
}

public extension Thenable where T: Sequence {
    func map<U>(on: DispatchQueue? = conf.Q.map, _ transform: @escaping(T.Iterator.Element) throws -> U) -> Promise<[U]> {
        return map(on: on){ try $0.map(transform) }
    }

    func thenMap<U: Thenable>(on: DispatchQueue? = conf.Q.map, _ transform: @escaping(T.Iterator.Element) throws -> U) -> Promise<[U.T]> {
        return then(on: on) {
            when(fulfilled: try $0.map(transform))
        }
    }

    func flatMap<U>(on: DispatchQueue? = conf.Q.map, _ transform: @escaping(T.Iterator.Element) throws -> U?) -> Promise<[U]> {
        return map(on: on){ try $0.flatMap(transform) }
    }

    func thenFlatMap<U: Thenable>(on: DispatchQueue? = conf.Q.map, _ transform: @escaping(T.Iterator.Element) throws -> U) -> Promise<[U.T.Iterator.Element]> where U.T: Sequence {
        return then(on: on){
            when(fulfilled: try $0.map(transform))
        }.map(on: nil) {
            $0.flatMap{ $0 }
        }
    }

    func filter(on: DispatchQueue? = conf.Q.map, test: @escaping (T.Iterator.Element) -> Bool) -> Promise<[T.Iterator.Element]> {
        return map(on: on) { $0.filter(test) }
    }
}

public extension Thenable where T: Collection {
    var first: Promise<T.Iterator.Element> {
        return map(on: nil) { aa in
            if let a1 = aa.first {
                return a1
            } else {
                throw PMKError.badInput
            }
        }
    }

    var last: Promise<T.Iterator.Element> {
        return map(on: nil) { aa in
            if aa.isEmpty {
                throw PMKError.badInput
            } else {
                let i = aa.index(aa.endIndex, offsetBy: -1)
                return aa[i]
            }
        }
    }
}

public extension Thenable where T: Sequence, T.Iterator.Element: Comparable {
    func sorted(on: DispatchQueue? = conf.Q.map) -> Promise<[T.Iterator.Element]> {
        return map(on: on){ $0.sorted() }
    }
}

private func _when<U: Thenable>(_ thenables: [U]) -> Promise<Void> {
    var countdown = thenables.count
    guard countdown > 0 else {
        return Promise(value: Void())
    }

    let rp = Promise<Void>(.pending)

#if PMKDisableProgress || os(Linux)
    var progress: (completedUnitCount: Int, totalUnitCount: Int) = (0, 0)
#else
    let progress = Progress(totalUnitCount: Int64(thenables.count))
    progress.isCancellable = false
    progress.isPausable = false
#endif

    let barrier = DispatchQueue(label: "org.promisekit.barrier.when", attributes: .concurrent)

    for promise in thenables {
        promise.pipe { result in
            barrier.sync(flags: .barrier) {
                switch result {
                case .rejected(let error):
                    if rp.isPending {
                        progress.completedUnitCount = progress.totalUnitCount
                        rp.box.seal(.rejected(error))
                    }
                case .fulfilled:
                    guard rp.isPending else { return }
                    progress.completedUnitCount += 1
                    countdown -= 1
                    if countdown == 0 {
                        rp.box.seal(.fulfilled(()))
                    }
                }
            }
        }
    }

    return rp
}

/**
 Wait for all promises in a set to fulfill.

 For example:

     when(fulfilled: promise1, promise2).then { results in
         //…
     }.catch { error in
         switch error {
         case URLError.notConnectedToInternet:
             //…
         case CLError.denied:
             //…
         }
     }

 - Note: If *any* of the provided promises reject, the returned promise is immediately rejected with that error.
 - Warning: In the event of rejection the other promises will continue to resolve and, as per any other promise, will either fulfill or reject. This is the right pattern for `getter` style asynchronous tasks, but often for `setter` tasks (eg. storing data on a server), you most likely will need to wait on all tasks and then act based on which have succeeded and which have failed, in such situations use `when(resolved:)`.
 - Parameter promises: The promises upon which to wait before the returned promise resolves.
 - Returns: A new promise that resolves when all the provided promises fulfill or one of the provided promises rejects.
 - Note: `when` provides `NSProgress`.
 - SeeAlso: `when(resolved:)`
*/
public func when<U: Thenable>(fulfilled thenables: [U]) -> Promise<[U.T]> {
    return _when(thenables).map(on: nil) { thenables.map{ $0.value! } }
}

public func when<U: Thenable>(fulfilled promises: U...) -> Promise<Void> where U.T == Void {
    return _when(promises)
}

public func when<U: Thenable>(fulfilled promises: [U]) -> Promise<Void> where U.T == Void {
    return _when(promises)
}

public func when<U: Thenable, V: Thenable>(fulfilled pu: U, _ pv: V) -> Promise<(U.T, V.T)> {
    return _when([pu.asVoid(), pv.asVoid()]).map(on: nil) { (pu.value!, pv.value!) }
}

public func when<U: Thenable, V: Thenable, W: Thenable>(fulfilled pu: U, _ pv: V, _ pw: W) -> Promise<(U.T, V.T, W.T)> {
    return _when([pu.asVoid(), pv.asVoid(), pw.asVoid()]).map(on: nil) { (pu.value!, pv.value!, pw.value!) }
}

public func when<U: Thenable, V: Thenable, W: Thenable, X: Thenable>(fulfilled pu: U, _ pv: V, _ pw: W, _ px: X) -> Promise<(U.T, V.T, W.T, X.T)> {
    return _when([pu.asVoid(), pv.asVoid(), pw.asVoid(), px.asVoid()]).map(on: nil) { (pu.value!, pv.value!, pw.value!, px.value!) }
}

public func when<U: Thenable, V: Thenable, W: Thenable, X: Thenable, Y: Thenable>(fulfilled pu: U, _ pv: V, _ pw: W, _ px: X, _ py: Y) -> Promise<(U.T, V.T, W.T, X.T, Y.T)> {
    return _when([pu.asVoid(), pv.asVoid(), pw.asVoid(), px.asVoid(), py.asVoid()]).map(on: nil) { (pu.value!, pv.value!, pw.value!, px.value!, py.value!) }
}

/**
 Generate promises at a limited rate and wait for all to fulfill.

 For example:
 
     func downloadFile(url: URL) -> Promise<Data> {
         // ...
     }
 
     let urls: [URL] = /*…*/
     let urlGenerator = urls.makeIterator()

     let generator = AnyIterator<Promise<Data>> {
         guard url = urlGenerator.next() else {
             return nil
         }
         return downloadFile(url)
     }

     when(generator, concurrently: 3).done { datas in
         // ...
     }
 
 No more than three downloads will occur simultaneously.

 - Note: The generator is called *serially* on a *background* queue.
 - Warning: Refer to the warnings on `when(fulfilled:)`
 - Parameter promiseGenerator: Generator of promises.
 - Returns: A new promise that resolves when all the provided promises fulfill or one of the provided promises rejects.
 - SeeAlso: `when(resolved:)`
 */

public func when<It: IteratorProtocol>(fulfilled promiseIterator: It, concurrently: Int) -> Promise<[It.Element.T]> where It.Element: Thenable {

    guard concurrently > 0 else {
        return Promise(error: PMKError.badInput)
    }

    var generator = promiseIterator
    var root = Promise<[It.Element.T]>.pending()
    var pendingPromises = 0
    var promises: [It.Element] = []

    let barrier = DispatchQueue(label: "org.promisekit.barrier.when", attributes: [.concurrent])

    func dequeue() {
        guard root.promise.isPending else { return }  // don’t continue dequeueing if root has been rejected

        var shouldDequeue = false
        barrier.sync {
            shouldDequeue = pendingPromises < concurrently
        }
        guard shouldDequeue else { return }

        var index: Int!
        var promise: It.Element!

        barrier.sync(flags: .barrier) {
            guard let next = generator.next() else { return }

            promise = next
            index = promises.count

            pendingPromises += 1
            promises.append(next)
        }

        func testDone() {
            barrier.sync {
                if pendingPromises == 0 {
                    root.resolver.fulfill(promises.flatMap{ $0.value })
                }
            }
        }

        guard promise != nil else {
            return testDone()
        }

        promise.pipe { resolution in
            barrier.sync(flags: .barrier) {
                pendingPromises -= 1
            }

            switch resolution {
            case .fulfilled:
                dequeue()
                testDone()
            case .rejected(let error):
                root.resolver.reject(error)
            }
        }

        dequeue()
    }
        
    dequeue()

    return root.promise
}

/**
 Waits on all provided promises.

 `when(fulfilled:)` rejects as soon as one of the provided promises rejects. `when(resolved:)` waits on all provided promises and **never** rejects.

     when(resolved: promise1, promise2, promise3).then { results in
         for result in results where case .fulfilled(let value) {
            //…
         }
     }.catch { error in
         // invalid! Never rejects
     }

 - Returns: A new promise that resolves once all the provided promises resolve. The array is ordered the same as the input, ie. the result order is *not* resolution order.
 - Warning: The returned promise can *not* be rejected.
 - Note: Any promises that error are implicitly consumed, your UnhandledErrorHandler will not be called.
 - Remark: Doesn't take Thenable due to protocol associatedtype paradox
*/
public func when<T>(resolved promises: Promise<T>...) -> Guarantee<[Result<T>]> {
    return when(resolved: promises)
}

public func when<T>(resolved promises: [Promise<T>]) -> Guarantee<[Result<T>]> {
    guard !promises.isEmpty else {
        return Guarantee(value: [])
    }

    var countdown = promises.count
    let barrier = DispatchQueue(label: "org.promisekit.barrier.join", attributes: .concurrent)

    let rg = Guarantee<[Result<T>]>(.pending)
    for promise in promises {
        promise.pipe { result in
            barrier.sync(flags: .barrier) {
                countdown -= 1
            }
            barrier.sync {
                if countdown == 0 {
                    rg.box.seal(promises.map{ $0.result! })
                }
            }
        }
    }
    return rg
}

public func when(_ guarantees: Guarantee<Void>...) -> Guarantee<Void> {
    return when(guarantees: guarantees)
}

public func when(guarantees: [Guarantee<Void>]) -> Guarantee<Void> {
    return when(fulfilled: guarantees).recover{ _ in }.asVoid()
}
