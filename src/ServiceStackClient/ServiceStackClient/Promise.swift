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
 - Returns: A new promise that fulfills after the specified duration.
*/
public func after(interval: TimeInterval) -> Promise<Void> {
    return Promise { fulfill, _ in
        let when = DispatchTime.now() + interval
        DispatchQueue.global().asyncAfter(deadline: when, execute: fulfill)
    }
}

/**
 AnyPromise is an Objective-C compatible promise.
*/
@objc(AnyPromise) public class AnyPromise: NSObject {
    let state: State<Any?>

    /**
     - Returns: A new `AnyPromise` bound to a `Promise<Any>`.
    */
    required public init(_ bridge: Promise<Any?>) {
        state = bridge.state
    }

    /// hack to ensure Swift picks the right initializer for each of the below
    private init(force: Promise<Any?>) {
        state = force.state
    }

    /**
     - Returns: A new `AnyPromise` bound to a `Promise<T>`.
    */
    public convenience init<T>(_ bridge: Promise<T?>) {
        self.init(force: bridge.then(on: zalgo) { $0 })
    }

    /**
     - Returns: A new `AnyPromise` bound to a `Promise<T>`.
    */
    convenience public init<T>(_ bridge: Promise<T>) {
        self.init(force: bridge.then(on: zalgo) { $0 })
    }

    /**
     - Returns: A new `AnyPromise` bound to a `Promise<Void>`.
     - Note: A “void” `AnyPromise` has a value of `nil`.
    */
    convenience public init(_ bridge: Promise<Void>) {
        self.init(force: bridge.then(on: zalgo) { nil })
    }

    /**
     Bridge an AnyPromise to a Promise<Any>
     - Note: AnyPromises fulfilled with `PMKManifold` lose all but the first fulfillment object.
     - Remark: Could not make this an initializer of `Promise` due to generics issues.
     */
    public func asPromise() -> Promise<Any?> {
        return Promise(sealant: { resolve in
            state.pipe { resolution in
                switch resolution {
                case .rejected:
                    resolve(resolution)
                case .fulfilled:
                    let obj = (self as AnyObject).value(forKey: "value")
                    resolve(.fulfilled(obj))
                }
            }
        })
    }

    /// - See: `Promise.then()`
    public func then<T>(on q: DispatchQueue = .default, execute body: @escaping (Any?) throws -> T) -> Promise<T> {
        return asPromise().then(on: q, execute: body)
    }

    /// - See: `Promise.then()`
    public func then(on q: DispatchQueue = .default, execute body: @escaping (Any?) throws -> AnyPromise) -> Promise<Any?> {
        return asPromise().then(on: q, execute: body)
    }

    /// - See: `Promise.then()`
    public func then<T>(on q: DispatchQueue = .default, execute body: @escaping (Any?) throws -> Promise<T>) -> Promise<T> {
        return asPromise().then(on: q, execute: body)
    }

    /// - See: `Promise.always()`
    public func always(on q: DispatchQueue = .default, execute body: @escaping () -> Void) -> Promise<Any?> {
        return asPromise().always(execute: body)
    }

    /// - See: `Promise.tap()`
    public func tap(on q: DispatchQueue = .default, execute body: @escaping (Result<Any?>) -> Void) -> Promise<Any?> {
        return asPromise().tap(execute: body)
    }

    /// - See: `Promise.recover()`
    public func recover(on q: DispatchQueue = .default, policy: CatchPolicy = .allErrorsExceptCancellation, execute body: @escaping (Error) throws -> Promise<Any?>) -> Promise<Any?> {
        return asPromise().recover(on: q, policy: policy, execute: body)
    }

    /// - See: `Promise.recover()`
    public func recover(on q: DispatchQueue = .default, policy: CatchPolicy = .allErrorsExceptCancellation, execute body: @escaping (Error) throws -> Any?) -> Promise<Any?> {
        return asPromise().recover(on: q, policy: policy, execute: body)
    }

    /// - See: `Promise.catch()`
    public func `catch`(on q: DispatchQueue = .default, policy: CatchPolicy = .allErrorsExceptCancellation, execute body: @escaping (Error) -> Void) {
        state.catch(on: q, policy: policy, else: { _ in }, execute: body)
    }


    /**
     A promise starts pending and eventually resolves.
     - Returns: `true` if the promise has not yet resolved.
     */
    @objc public var pending: Bool {
        return state.get() == nil
    }

    /**
     A promise starts pending and eventually resolves.
     - Returns: `true` if the promise has resolved.
     */
    @objc public var resolved: Bool {
        return !pending
    }

    /**
     The value of the asynchronous task this promise represents.

     A promise has `nil` value if the asynchronous task it represents has not finished. If the value is `nil` the promise is still `pending`.

     - Warning: *Note* Our Swift variant’s value property returns nil if the promise is rejected where AnyPromise will return the error object. This fits with the pattern where AnyPromise is not strictly typed and is more dynamic, but you should be aware of the distinction.
     
     - Note: If the AnyPromise was fulfilled with a `PMKManifold`, returns only the first fulfillment object.

     - Returns If `resolved`, the object that was used to resolve this promise; if `pending`, nil.
     */
    @objc private var __value: Any? {
        switch state.get() {
        case nil:
            return nil
        case .rejected(let error, _)?:
            return error
        case .fulfilled(let obj)?:
            return obj
        }
    }

    /**
     Creates a resolved promise.

     When developing your own promise systems, it is ocassionally useful to be able to return an already resolved promise.

     - Parameter value: The value with which to resolve this promise. Passing an `NSError` will cause the promise to be rejected, passing an AnyPromise will return a new AnyPromise bound to that promise, otherwise the promise will be fulfilled with the value passed.

     - Returns: A resolved promise.
     */
    @objc public class func promiseWithValue(_ value: Any?) -> AnyPromise {
        let state: State<Any?>
        switch value {
        case let promise as AnyPromise:
            state = promise.state
        case let err as Error:
            state = SealedState(resolution: Resolution(err))
        default:
            state = SealedState(resolution: .fulfilled(value))
        }
        return AnyPromise(state: state)
    }

    private init(state: State<Any?>) {
        self.state = state
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
    @objc public class func promiseWithResolverBlock(_ body: (@escaping (Any?) -> Void) -> Void) -> AnyPromise {
        return AnyPromise(sealant: { resolve in
            body { obj in
                makeHandler({ _ in obj }, resolve)(obj)
            }
        })
    }

    private init(sealant: (@escaping (Resolution<Any?>) -> Void) -> Void) {
        var resolve: ((Resolution<Any?>) -> Void)!
        state = UnsealedState(resolver: &resolve)
        sealant(resolve)
    }

    @objc func __thenOn(_ q: DispatchQueue, execute body: @escaping (Any?) -> Any?) -> AnyPromise {
        return AnyPromise(sealant: { resolve in
            state.then(on: q, else: resolve, execute: makeHandler(body, resolve))
        })
    }

    func __catchWithPolicy(_ policy: CatchPolicy, execute body: @escaping (Any?) -> Any?) -> AnyPromise {
        return AnyPromise(sealant: { resolve in
            state.catch(on: .default, policy: policy, else: resolve) { err in
                makeHandler(body, resolve)(err as NSError)
            }
        })
    }

    @objc func __alwaysOn(_ q: DispatchQueue, execute body: @escaping () -> Void) -> AnyPromise {
        return AnyPromise(sealant: { resolve in
            state.always(on: q) { resolution in
                body()
                resolve(resolution)
            }
        })
    }

    /**
     Convert an `AnyPromise` to `Promise<T>`.

         anyPromise.toPromise(T).then { (t: T) -> U in ... }
     
     - Returns: A `Promise<T>` with the requested type.
     - Throws: `CastingError.CastingAnyPromiseFailed(T)` if self's value cannot be downcasted to the given type.
     */
    public func asPromise<T>(type: T.Type) -> Promise<T> {
        return self.then(on: zalgo) { (value: Any?) -> T in
            if let value = value as? T {
                return value
            }
            throw PMKError.castError(type)
        }
    }

    /// used by PMKWhen and PMKJoin
    @objc func __pipe(_ body: @escaping (Any?) -> Void) {
        state.pipe { resolution in
            switch resolution {
            case .rejected(let error, let token):
                token.consumed = true  // when and join will create a new parent error that is unconsumed
                body(error as Error)
            case .fulfilled(let value):
                body(value)
            }
        }
    }
}


extension AnyPromise {
    override public var description: String {
        return "AnyPromise: \(state)"
    }
}

private func makeHandler(_ body: @escaping (Any?) -> Any?, _ resolve: @escaping (Resolution<Any?>) -> Void) -> (Any?) -> Void {
    return { obj in
        let obj = body(obj)
        switch obj {
        case let err as Error:
            resolve(Resolution(err))
        case let promise as AnyPromise:
            promise.state.pipe(resolve)
        default:
            resolve(.fulfilled(obj))
        }
    }
}

/**
 ```
 DispatchQueue.global().promise {
     try md5(input)
 }.then { md5 in
     //…
 }
 ```

 - Parameter body: The closure that resolves this promise.
 - Returns: A new promise resolved by the result of the provided closure.
*/
extension DispatchQueue {
    /**
     - SeeAlso: `dispatch_promise()`
     - SeeAlso: `dispatch_promise_on()`
     */
    public final func promise<T>(group: DispatchGroup? = nil, qos: DispatchQoS = .default, flags: DispatchWorkItemFlags = [], execute body: @escaping () throws -> T) -> Promise<T> {

        return Promise(sealant: { resolve in
            async(group: group, qos: qos, flags: flags) {
                do {
                    resolve(.fulfilled(try body()))
                } catch {
                    resolve(Resolution(error))
                }
            }
        })
    }

    /// Unavailable due to Swift compiler issues
    @available(*, unavailable)
    public final func promise<T>(group: DispatchGroup? = nil, qos: DispatchQoS = .default, flags: DispatchWorkItemFlags = [], execute body: () throws -> Promise<T>) -> Promise<T> { fatalError() }

    /**
     - SeeAlso: `PMKDefaultDispatchQueue()`
     - SeeAlso: `PMKSetDefaultDispatchQueue()`
     */
    class public final var `default`: DispatchQueue {
        get {
            return __PMKDefaultDispatchQueue()
        }
        set {
            __PMKSetDefaultDispatchQueue(newValue)
        }
    }
}

public enum PMKError: Error {
    /**
     The ErrorType for a rejected `join`.
     - Parameter 0: The promises passed to this `join` that did not *all* fulfill.
     - Note: The array is untyped because Swift generics are fussy with enums.
    */
    case join([AnyObject])

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

    /** `when()` was called with a concurrency of <= 0 */
    case whenConcurrentlyZero

    /** AnyPromise.toPromise failed to cast as requested */
    case castError(Any.Type)
}

public enum PMKURLError: Error {
    /**
     The URLRequest succeeded but a valid UIImage could not be decoded from
     the data that was received.
    */
    case invalidImageData(URLRequest, Data)

    /**
     The HTTP request returned a non-200 status code.
    */
    case badResponse(URLRequest, Data?, URLResponse?)

    /**
     The data could not be decoded using the encoding specified by the HTTP
     response headers.
    */
    case stringEncoding(URLRequest, Data, URLResponse)

    /**
     Usually the `NSURLResponse` is actually an `NSHTTPURLResponse`, if so you
     can access it using this property. Since it is returned as an unwrapped
     optional: be sure.
    */
    public var NSHTTPURLResponse: Foundation.HTTPURLResponse! {
        switch self {
        case .invalidImageData:
            return nil
        case .badResponse(_, _, let rsp):
            return rsp as! Foundation.HTTPURLResponse
        case .stringEncoding(_, _, let rsp):
            return rsp as! Foundation.HTTPURLResponse
        }
    }
}

public enum JSONError: Error {
    /// The JSON response was different to that requested
    case unexpectedRootNode(Any)
}



public protocol CancellableError: Error {
    var isCancelled: Bool { get }
}

#if !SWIFT_PACKAGE

private struct ErrorPair: Hashable {
    let domain: String
    let code: Int
    init(_ d: String, _ c: Int) {
        domain = d; code = c
    }
    var hashValue: Int {
        return "\(domain):\(code)".hashValue
    }
}

private func ==(lhs: ErrorPair, rhs: ErrorPair) -> Bool {
    return lhs.domain == rhs.domain && lhs.code == rhs.code
}

extension NSError {
    @objc public class func cancelledError() -> NSError {
        let info = [NSLocalizedDescriptionKey: "The operation was cancelled"]
        return NSError(domain: PMKErrorDomain, code: PMKOperationCancelled, userInfo: info)
    }

    /**
      - Warning: You must call this method before any promises in your application are rejected. Failure to ensure this may lead to concurrency crashes.
      - Warning: You must call this method on the main thread. Failure to do this may lead to concurrency crashes.
     */
    @objc public class func registerCancelledErrorDomain(_ domain: String, code: Int) {
        cancelledErrorIdentifiers.insert(ErrorPair(domain, code))
    }

    /// - Returns: true if the error represents cancellation.
    @objc public var isCancelled: Bool {
        return (self as Error).isCancelledError
    }
}

private var cancelledErrorIdentifiers = Set([
    ErrorPair(PMKErrorDomain, PMKOperationCancelled),
    ErrorPair(NSURLErrorDomain, NSURLErrorCancelled),
])

#endif


extension Error {
    public var isCancelledError: Bool {
        if let ce = self as? CancellableError {
            return ce.isCancelled
        } else {
          #if SWIFT_PACKAGE
            return false
          #else
            let ne = self as NSError
            return cancelledErrorIdentifiers.contains(ErrorPair(ne.domain, ne.code))
          #endif
        }
    }
}


class ErrorConsumptionToken {
    var consumed = false
    let error: Error

    init(_ error: Error) {
        self.error = error
    }

    deinit {
        if !consumed {
            PMKUnhandledErrorHandler(error as NSError)
        }
    }
}

/**
 Waits on all provided promises.

 `when` rejects as soon as one of the provided promises rejects. `join` waits on all provided promises, then rejects if any of those promises rejected, otherwise it fulfills with values from the provided promises.

     join(promise1, promise2, promise3).then { results in
         //…
     }.catch { error in
         switch error {
         case Error.Join(let promises):
             //…
         }
     }

 - Returns: A new promise that resolves once all the provided promises resolve.
 - SeeAlso: `PromiseKit.Error.join`
*/
@available(*, deprecated: 4.0, message: "Use when(resolved:)")
public func join<T>(_ promises: Promise<T>...) -> Promise<[T]> {
    return join(promises)
}

@available(*, deprecated: 4.0, message: "Use when(resolved:)")
public func join(_ promises: [Promise<Void>]) -> Promise<Void> {
    return join(promises).then(on: zalgo) { (_: [Void]) in return Promise(value: ()) }
}

@available(*, deprecated: 4.0, message: "Use when(resolved:)")
public func join<T>(_ promises: [Promise<T>]) -> Promise<[T]> {
    guard !promises.isEmpty else { return Promise(value: []) }
  
    var countdown = promises.count
    let barrier = DispatchQueue(label: "org.promisekit.barrier.join", attributes: .concurrent)
    var rejected = false

    return Promise { fulfill, reject in
        for promise in promises {
            promise.state.pipe { resolution in
                __dispatch_barrier_sync(barrier) {
                    if case .rejected(_, let token) = resolution {
                        token.consumed = true  // the parent Error.Join consumes all
                        rejected = true
                    }
                    countdown -= 1
                    if countdown == 0 {
                        if rejected {
                            reject(PMKError.join(promises))
                        } else {
                            fulfill(promises.map{ $0.value! })
                        }
                    }
                }
            }
        }
    }
}
extension Promise {
    /**
     - Returns: The error with which this promise was rejected; `nil` if this promise is not rejected.
    */
    public var error: Error? {
        switch state.get() {
        case .none:
            return nil
        case .some(.fulfilled):
            return nil
        case .some(.rejected(let error, _)):
            return error
        }
    }

    /**
     - Returns: `true` if the promise has not yet resolved.
    */
    public var isPending: Bool {
        return state.get() == nil
    }

    /**
     - Returns: `true` if the promise has resolved.
    */
    public var isResolved: Bool {
        return !isPending
    }

    /**
     - Returns: `true` if the promise was fulfilled.
    */
    public var isFulfilled: Bool {
        return value != nil
    }

    /**
     - Returns: `true` if the promise was rejected.
    */
    public var isRejected: Bool {
        return error != nil
    }

    /**
     - Returns: The value with which this promise was fulfilled or `nil` if this promise is pending or rejected.
    */
    public var value: T? {
        switch state.get() {
        case .none:
            return nil
        case .some(.fulfilled(let value)):
            return value
        case .some(.rejected):
            return nil
        }
    }
}


/**
 A *promise* represents the future value of a (usually) asynchronous task.

 To obtain the value of a promise we call `then`.

 Promises are chainable: `then` returns a promise, you can call `then` on
 that promise, which returns a promise, you can call `then` on that
 promise, et cetera.

 Promises start in a pending state and *resolve* with a value to become
 *fulfilled* or an `Error` to become rejected.

 - SeeAlso: [PromiseKit `then` Guide](http://promisekit.org/docs/)
 */
open class Promise<T> {
    let state: State<T>

    /**
     Create a new, pending promise.

         func fetchAvatar(user: String) -> Promise<UIImage> {
             return Promise { fulfill, reject in
                 MyWebHelper.GET("\(user)/avatar") { data, err in
                     guard let data = data else { return reject(err) }
                     guard let img = UIImage(data: data) else { return reject(MyError.InvalidImage) }
                     guard let img.size.width > 0 else { return reject(MyError.ImageTooSmall) }
                     fulfill(img)
                 }
             }
         }

     - Parameter resolvers: The provided closure is called immediately on the active thread; commence your asynchronous task, calling either fulfill or reject when it completes.
      - Parameter fulfill: Fulfills this promise with the provided value.
      - Parameter reject: Rejects this promise with the provided error.

     - Returns: A new promise.

     - Note: If you are wrapping a delegate-based system, we recommend
     to use instead: `Promise.pending()`

     - SeeAlso: http://promisekit.org/docs/sealing-promises/
     - SeeAlso: http://promisekit.org/docs/cookbook/wrapping-delegation/
     - SeeAlso: pending()
     */
    required public init(resolvers: (_ fulfill: @escaping (T) -> Void, _ reject: @escaping (Error) -> Void) throws -> Void) {
        var resolve: ((Resolution<T>) -> Void)!
        do {
            state = UnsealedState(resolver: &resolve)
            try resolvers({ resolve(.fulfilled($0)) }, { error in
                #if !PMKDisableWarnings
                    if self.isPending {
                        resolve(Resolution(error))
                    } else {
                        NSLog("PromiseKit: warning: reject called on already rejected Promise: \(error)")
                    }
                #else
                    resolve(Resolution(error))
                #endif
            })
        } catch {
            resolve(Resolution(error))
        }
    }

    /**
     Create an already fulfilled promise.
     */
    required public init(value: T) {
        state = SealedState(resolution: .fulfilled(value))
    }

    /**
     Create an already rejected promise.
     */
    required public init(error: Error) {
        state = SealedState(resolution: Resolution(error))
    }

    /**
     Careful with this, it is imperative that sealant can only be called once
     or you will end up with spurious unhandled-errors due to possible double
     rejections and thus immediately deallocated ErrorConsumptionTokens.
     */
    init(sealant: (@escaping (Resolution<T>) -> Void) -> Void) {
        var resolve: ((Resolution<T>) -> Void)!
        state = UnsealedState(resolver: &resolve)
        sealant(resolve)
    }

    /**
     A `typealias` for the return values of `pending()`. Simplifies declaration of properties that reference the values' containing tuple when this is necessary. For example, when working with multiple `pendingPromise(value: ())`s within the same scope, or when the promise initialization must occur outside of the caller's initialization.

         class Foo: BarDelegate {
            var task: Promise<Int>.PendingTuple?
         }

     - SeeAlso: pending()
     */
    public typealias PendingTuple = (promise: Promise, fulfill: (T) -> Void, reject: (Error) -> Void)

    /**
     Making promises that wrap asynchronous delegation systems or other larger asynchronous systems without a simple completion handler is easier with pending.

         class Foo: BarDelegate {
             let (promise, fulfill, reject) = Promise<Int>.pending()
    
             func barDidFinishWithResult(result: Int) {
                 fulfill(result)
             }
    
             func barDidError(error: NSError) {
                 reject(error)
             }
         }

     - Returns: A tuple consisting of: 
       1) A promise
       2) A function that fulfills that promise
       3) A function that rejects that promise
     */
    public final class func pending() -> PendingTuple {
        var fulfill: ((T) -> Void)!
        var reject: ((Error) -> Void)!
        let promise = self.init { fulfill = $0; reject = $1 }
        return (promise, fulfill, reject)
    }

    /**
     The provided closure is executed when this promise is resolved.

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter body: The closure that is executed when this Promise is fulfilled.
     - Returns: A new promise that is resolved with the value returned from the provided closure. For example:

           NSURLSession.GET(url).then { data -> Int in
               //…
               return data.length
           }.then { length in
               //…
           }
     */
    public func then<U>(on q: DispatchQueue = .default, execute body: @escaping (T) throws -> U) -> Promise<U> {
        return Promise<U> { resolve in
            state.then(on: q, else: resolve) { value in
                resolve(.fulfilled(try body(value)))
            }
        }
    }

    /**
     The provided closure executes when this promise resolves.
     
     This variant of `then` allows chaining promises, the promise returned by the provided closure is resolved before the promise returned by this closure resolves.

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter execute: The closure that executes when this promise fulfills.
     - Returns: A new promise that resolves when the promise returned from the provided closure resolves. For example:

           URLSession.GET(url1).then { data in
               return CLLocationManager.promise()
           }.then { location in
               //…
           }
     */
    public func then<U>(on q: DispatchQueue = .default, execute body: @escaping (T) throws -> Promise<U>) -> Promise<U> {
        var rv: Promise<U>!
        rv = Promise<U> { resolve in
            state.then(on: q, else: resolve) { value in
                let promise = try body(value)
                guard promise !== rv else { throw PMKError.returnedSelf }
                promise.state.pipe(resolve)
            }
        }
        return rv
    }

    /**
     The provided closure executes when this promise rejects.

     Rejecting a promise cascades: rejecting all subsequent promises (unless
     recover is invoked) thus you will typically place your catch at the end
     of a chain. Often utility promises will not have a catch, instead
     delegating the error handling to the caller.

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter policy: The default policy does not execute your handler for cancellation errors.
     - Parameter execute: The handler to execute if this promise is rejected.
     - Returns: `self`
     - SeeAlso: [Cancellation](http://promisekit.org/docs/)
     - Important: The promise that is returned is `self`. `catch` cannot affect the chain, in PromiseKit 3 no promise was returned to strongly imply this, however for PromiseKit 4 we started returning a promise so that you can `always` after a catch or return from a function that has an error handler.
     */
    @discardableResult
    public func `catch`(on q: DispatchQueue = .default, policy: CatchPolicy = .allErrorsExceptCancellation, execute body: @escaping (Error) -> Void) -> Promise {
        state.catch(on: q, policy: policy, else: { _ in }, execute: body)
        return self
    }

    /**
     The provided closure executes when this promise rejects.
     
     Unlike `catch`, `recover` continues the chain provided the closure does not throw. Use `recover` in circumstances where recovering the chain from certain errors is a possibility. For example:
     
         CLLocationManager.promise().recover { error in
             guard error == CLError.unknownLocation else { throw error }
             return CLLocation.Chicago
         }

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter policy: The default policy does not execute your handler for cancellation errors.
     - Parameter execute: The handler to execute if this promise is rejected.
     - SeeAlso: [Cancellation](http://promisekit.org/docs/)
     */
    public func recover(on q: DispatchQueue = .default, policy: CatchPolicy = .allErrorsExceptCancellation, execute body: @escaping (Error) throws -> Promise) -> Promise {
        var rv: Promise!
        rv = Promise { resolve in
            state.catch(on: q, policy: policy, else: resolve) { error in
                let promise = try body(error)
                guard promise !== rv else { throw PMKError.returnedSelf }
                promise.state.pipe(resolve)
            }
        }
        return rv
    }

    /**
     The provided closure executes when this promise rejects.

     Unlike `catch`, `recover` continues the chain provided the closure does not throw. Use `recover` in circumstances where recovering the chain from certain errors is a possibility. For example:

         CLLocationManager.promise().recover { error in
             guard error == CLError.unknownLocation else { throw error }
             return CLLocation.Chicago
         }

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter policy: The default policy does not execute your handler for cancellation errors.
     - Parameter execute: The handler to execute if this promise is rejected.
     - SeeAlso: [Cancellation](http://promisekit.org/docs/)
     */
    public func recover(on q: DispatchQueue = .default, policy: CatchPolicy = .allErrorsExceptCancellation, execute body: @escaping (Error) throws -> T) -> Promise {
        return Promise { resolve in
            state.catch(on: q, policy: policy, else: resolve) { error in
                resolve(.fulfilled(try body(error)))
            }
        }
    }

    /**
     The provided closure executes when this promise resolves.

         firstly {
             UIApplication.shared.networkActivityIndicatorVisible = true
         }.then {
             //…
         }.always {
             UIApplication.shared.networkActivityIndicatorVisible = false
         }.catch {
             //…
         }

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter execute: The closure that executes when this promise resolves.
     - Returns: A new promise, resolved with this promise’s resolution.
     */
    public func always(on q: DispatchQueue = .default, execute body: @escaping () -> Void) -> Promise {
        state.always(on: q) { resolution in
            body()
        }
        return self
    }

    /**
     `tap` allows you to “tap” into a promise chain and inspect its result.
     
     The function you provide cannot mutate the chain.
 
         NSURLSession.GET(/*…*/).tap { result in
             print(result)
         }

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter execute: The closure that executes when this promise resolves.
     - Returns: A new promise, resolved with this promise’s resolution.
     */
    @discardableResult
    public func tap(on q: DispatchQueue = .default, execute body: @escaping (Result<T>) -> Void) -> Promise {
        state.always(on: q) { resolution in
            body(Result(resolution))
        }
        return self
    }

    /**
     Void promises are less prone to generics-of-doom scenarios.
     - SeeAlso: when.swift contains enlightening examples of using `Promise<Void>` to simplify your code.
     */
    public func asVoid() -> Promise<Void> {
        return then(on: zalgo) { _ in return }
    }


    @available(*, unavailable, renamed: "always()")
    public func finally(on: DispatchQueue = DispatchQueue.main, execute body: () -> Void) -> Promise { fatalError() }

    @available(*, unavailable, renamed: "always()")
    public func ensure(on: DispatchQueue = DispatchQueue.main, execute body: () -> Void) -> Promise { fatalError() }

    @available(*, unavailable, renamed: "pending()")
    public class func `defer`() -> PendingTuple { fatalError() }

    @available(*, unavailable, renamed: "pending()")
    public class func `pendingPromise`() -> PendingTuple { fatalError() }

    @available(*, unavailable, message: "deprecated: use then(on: .global())")
    public func thenInBackground<U>(execute body: (T) throws -> U) -> Promise<U> { fatalError() }

    @available(*, unavailable, renamed: "catch")
    public func onError(policy: CatchPolicy = .allErrors, execute body: (Error) -> Void) { fatalError() }

    @available(*, unavailable, renamed: "catch")
    public func errorOnQueue(_ on: DispatchQueue, policy: CatchPolicy = .allErrors, execute body: (Error) -> Void) { fatalError() }

    @available(*, unavailable, renamed: "catch")
    public func error(policy: CatchPolicy, execute body: (Error) -> Void) { fatalError() }

    @available(*, unavailable, renamed: "catch")
    public func report(policy: CatchPolicy = .allErrors, execute body: (Error) -> Void) { fatalError() }

    @available(*, unavailable, renamed: "init(value:)")
    public init(_ value: T) { fatalError() }


    @available(*, unavailable, message: "cannot instantiate Promise<Error>")
    public init<T: Error>(resolvers: (_ fulfill: (T) -> Void, _ reject: (Error) -> Void) throws -> Void) { fatalError() }

    @available(*, unavailable, message: "cannot instantiate Promise<Error>")
    public class func pending<T: Error>() -> (promise: Promise, fulfill: (T) -> Void, reject: (Error) -> Void) { fatalError() }


    @available (*, unavailable, message: "instead of returning the error; throw")
    public func then<U: Error>(on: DispatchQueue = .default, execute body: (T) throws -> U) -> Promise<U> { fatalError() }

    @available (*, unavailable, message: "instead of returning the error; throw")
    public func recover<T: Error>(on: DispatchQueue = .default, execute body: (Error) throws -> T) -> Promise { fatalError() }


    @available(*, unavailable, message: "unwrap the promise")
    public func then<U>(on: DispatchQueue = .default, execute body: (T) throws -> Promise<U>?) -> Promise<U> { fatalError() }

    @available(*, unavailable, message: "unwrap the promise")
    public func recover(on: DispatchQueue = .default, execute body: (Error) throws -> Promise?) -> Promise { fatalError() }
}

extension Promise: CustomStringConvertible {
    public var description: String {
        return "Promise: \(state)"
    }
}

/**
 Judicious use of `firstly` *may* make chains more readable.

 Compare:

     NSURLSession.GET(url1).then {
         NSURLSession.GET(url2)
     }.then {
         NSURLSession.GET(url3)
     }

 With:

     firstly {
         NSURLSession.GET(url1)
     }.then {
         NSURLSession.GET(url2)
     }.then {
         NSURLSession.GET(url3)
     }
 */
public func firstly<T>(execute body: () throws -> Promise<T>) -> Promise<T> {
    do {
        return try body()
    } catch {
        return Promise(error: error)
    }
}

@available(*, unavailable, message: "instead of returning the error; throw")
public func firstly<T: Error>(execute body: () throws -> T) -> Promise<T> { fatalError() }

@available(*, unavailable, message: "use DispatchQueue.promise")
public func firstly<T>(on: DispatchQueue, execute body: () throws -> Promise<T>) -> Promise<T> { fatalError() }

@available(*, deprecated: 4.0, renamed: "DispatchQueue.promise")
public func dispatch_promise<T>(_ on: DispatchQueue, _ body: @escaping () throws -> T) -> Promise<T> {
    return Promise(value: ()).then(on: on, execute: body)
}


/**
 The underlying resolved state of a promise.
 - remark: Same as `Resolution<T>` but without the associated `ErrorConsumptionToken`.
*/
public enum Result<T> {
    /// Fulfillment
    case fulfilled(T)
    /// Rejection
    case rejected(Error)

    init(_ resolution: Resolution<T>) {
        switch resolution {
        case .fulfilled(let value):
            self = .fulfilled(value)
        case .rejected(let error, _):
            self = .rejected(error)
        }
    }

    public var boolValue: Bool {
        switch self {
        case .fulfilled:
            return true
        case .rejected:
            return false
        }
    }
}


public class PMKJoint<T> {
    fileprivate var resolve: ((Resolution<T>) -> Void)!
}

extension Promise {
    public final class func joint() -> (Promise<T>, (PMKJoint<T>)) {
        let pipe = PMKJoint<T>()
        let promise = Promise(sealant: { pipe.resolve = $0 })
        return (promise, pipe)
    }

    public func join(_ joint: PMKJoint<T>) {
        state.pipe(joint.resolve)
    }
}


extension Promise where T: Collection {
    /**
     `map` transforms a `Promise` where `T` is a `Collection`, eg. an `Array` returning a `Promise<[U]>`

         URLSession.shared.dataTask(url: /*…*/).asArray().map { result in
             return download(result)
         }.then { images in
             // images is `[UIImage]`
         }

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter transform: The closure that executes when this promise resolves.
     - Returns: A new promise, resolved with this promise’s resolution.
     */
    public func map<U>(on: DispatchQueue = .default, transform: @escaping (T.Iterator.Element) throws -> Promise<U>) -> Promise<[U]> {
        return Promise<[U]> { resolve in
            return state.then(on: zalgo, else: resolve) { tt in
                when(fulfilled: try tt.map(transform)).state.pipe(resolve)
            }
        }
    }
}
/**
 Resolves with the first resolving promise from a set of promises.

 ```
 race(promise1, promise2, promise3).then { winner in
     //…
 }
 ```

 - Returns: A new promise that resolves when the first promise in the provided promises resolves.
 - Warning: If any of the provided promises reject, the returned promise is rejected.
 - Warning: aborts if the array is empty.
*/
public func race<T>(promises: [Promise<T>]) -> Promise<T> {
    guard promises.count > 0 else {
        fatalError("Cannot race with an empty array of promises")
    }
    return _race(promises: promises)
}

/**
 Resolves with the first resolving promise from a set of promises.

 ```
 race(promise1, promise2, promise3).then { winner in
     //…
 }
 ```

 - Returns: A new promise that resolves when the first promise in the provided promises resolves.
 - Warning: If any of the provided promises reject, the returned promise is rejected.
 - Warning: aborts if the array is empty.
*/
public func race<T>(_ promises: Promise<T>...) -> Promise<T> {
    return _race(promises: promises)
}

private func _race<T>(promises: [Promise<T>]) -> Promise<T> {
    return Promise(sealant: { resolve in
        for promise in promises {
            promise.state.pipe(resolve)
        }
    })
}

enum Seal<T> {
    case pending(Handlers<T>)
    case resolved(Resolution<T>)
}

enum Resolution<T> {
    case fulfilled(T)
    case rejected(Error, ErrorConsumptionToken)

    init(_ error: Error) {
        self = .rejected(error, ErrorConsumptionToken(error))
    }
}

class State<T> {

    // would be a protocol, but you can't have typed variables of “generic”
    // protocols in Swift 2. That is, I couldn’t do var state: State<R> when
    // it was a protocol. There is no work around. Update: nor Swift 3

    func get() -> Resolution<T>? { fatalError("Abstract Base Class") }
    func get(body: @escaping (Seal<T>) -> Void) { fatalError("Abstract Base Class") }

    final func pipe(_ body: @escaping (Resolution<T>) -> Void) {
        get { seal in
            switch seal {
            case .pending(let handlers):
                handlers.append(body)
            case .resolved(let resolution):
                body(resolution)
            }
        }
    }

    final func then<U>(on q: DispatchQueue, else rejecter: @escaping (Resolution<U>) -> Void, execute body: @escaping (T) throws -> Void) {
        pipe { resolution in
            switch resolution {
            case .fulfilled(let value):
                contain_zalgo(q, rejecter: rejecter) {
                    try body(value)
                }
            case .rejected(let error, let token):
                rejecter(.rejected(error, token))
            }
        }
    }

    final func always(on q: DispatchQueue, body: @escaping (Resolution<T>) -> Void) {
        pipe { resolution in
            contain_zalgo(q) {
                body(resolution)
            }
        }
    }

    final func `catch`(on q: DispatchQueue, policy: CatchPolicy, else resolve: @escaping (Resolution<T>) -> Void, execute body: @escaping (Error) throws -> Void) {
        pipe { resolution in
            switch (resolution, policy) {
            case (.fulfilled, _):
                resolve(resolution)
            case (.rejected(let error, _), .allErrorsExceptCancellation) where error.isCancelledError:
                resolve(resolution)
            case (let .rejected(error, token), _):
                contain_zalgo(q, rejecter: resolve) {
                    token.consumed = true
                    try body(error)
                }
            }
        }
    }
}

class UnsealedState<T>: State<T> {
    private let barrier = DispatchQueue(label: "org.promisekit.barrier", attributes: .concurrent)
    private var seal: Seal<T>

    /**
     Quick return, but will not provide the handlers array because
     it could be modified while you are using it by another thread.
     If you need the handlers, use the second `get` variant.
    */
    override func get() -> Resolution<T>? {
        var result: Resolution<T>?
        barrier.sync {
            if case .resolved(let resolution) = self.seal {
                result = resolution
            }
        }
        return result
    }

    override func get(body: @escaping (Seal<T>) -> Void) {
        var sealed = false
        barrier.sync {
            switch self.seal {
            case .resolved:
                sealed = true
            case .pending:
                sealed = false
            }
        }
        if !sealed {
            __dispatch_barrier_sync(barrier) {
                switch (self.seal) {
                case .pending:
                    body(self.seal)
                case .resolved:
                    sealed = true  // welcome to race conditions
                }
            }
        }
        if sealed {
            body(seal)  // as much as possible we do things OUTSIDE the barrier_sync
        }
    }

    required init(resolver: inout ((Resolution<T>) -> Void)!) {
        seal = .pending(Handlers<T>())
        super.init()
        resolver = { resolution in
            var handlers: Handlers<T>?
            __dispatch_barrier_sync(self.barrier) {
                if case .pending(let hh) = self.seal {
                    self.seal = .resolved(resolution)
                    handlers = hh
                }
            }
            if let handlers = handlers {
                for handler in handlers {
                    handler(resolution)
                }
            }
        }
    }
#if !PMKDisableWarnings
    deinit {
        if case .pending = seal {
            NSLog("PromiseKit: Pending Promise deallocated! This is usually a bug")
        }
    }
#endif
}

class SealedState<T>: State<T> {
    fileprivate let resolution: Resolution<T>
    
    init(resolution: Resolution<T>) {
        self.resolution = resolution
    }
    
    override func get() -> Resolution<T>? {
        return resolution
    }

    override func get(body: @escaping (Seal<T>) -> Void) {
        body(.resolved(resolution))
    }
}


class Handlers<T>: Sequence {
    var bodies: [(Resolution<T>) -> Void] = []

    func append(_ body: @escaping (Resolution<T>) -> Void) {
        bodies.append(body)
    }

    func makeIterator() -> IndexingIterator<[(Resolution<T>) -> Void]> {
        return bodies.makeIterator()
    }

    var count: Int {
        return bodies.count
    }
}


extension Resolution: CustomStringConvertible {
    var description: String {
        switch self {
        case .fulfilled(let value):
            return "Fulfilled with value: \(value)"
        case .rejected(let error):
            return "Rejected with error: \(error)"
        }
    }
}

extension UnsealedState: CustomStringConvertible {
    var description: String {
        var rv: String!
        get { seal in
            switch seal {
            case .pending(let handlers):
                rv = "Pending with \(handlers.count) handlers"
            case .resolved(let resolution):
                rv = "\(resolution)"
            }
        }
        return "UnsealedState: \(rv)"
    }
}

extension SealedState: CustomStringConvertible {
    var description: String {
        return "SealedState: \(resolution)"
    }
}
public enum CatchPolicy {
    case allErrorsExceptCancellation
    case allErrors
}

func PMKUnhandledErrorHandler(_ error: Error)
{}


func __PMKDefaultDispatchQueue() -> DispatchQueue {
    return DispatchQueue.main
}

func __PMKSetDefaultDispatchQueue(_: DispatchQueue)
{}

private func _when<T>(_ promises: [Promise<T>]) -> Promise<Void> {
    let root = Promise<Void>.pending()
    var countdown = promises.count
    guard countdown > 0 else {
        root.fulfill()
        return root.promise
    }

#if !PMKDisableProgress
    let progress = Progress(totalUnitCount: Int64(promises.count))
    progress.isCancellable = false
    progress.isPausable = false
#else
    var progress: (completedUnitCount: Int, totalUnitCount: Int) = (0, 0)
#endif
    
    let barrier = DispatchQueue(label: "org.promisekit.barrier.when", attributes: .concurrent)

    for promise in promises {
        promise.state.pipe { resolution in
            __dispatch_barrier_sync(barrier) {
                switch resolution {
                case .rejected(let error, let token):
                    token.consumed = true
                    if root.promise.isPending {
                        progress.completedUnitCount = progress.totalUnitCount
                        root.reject(error)
                    }
                case .fulfilled:
                    guard root.promise.isPending else { return }
                    progress.completedUnitCount += 1
                    countdown -= 1
                    if countdown == 0 {
                        root.fulfill()
                    }
                }
            }
        }
    }

    return root.promise
}

/**
 Wait for all promises in a set to fulfill.

 For example:

     when(fulfilled: promise1, promise2).then { results in
         //…
     }.catch { error in
         switch error {
         case NSURLError.NoConnection:
             //…
         case CLError.NotAuthorized:
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
public func when<T>(fulfilled promises: [Promise<T>]) -> Promise<[T]> {
    return _when(promises).then(on: zalgo) { promises.map{ $0.value! } }
}

public func when(fulfilled promises: Promise<Void>...) -> Promise<Void> {
    return _when(promises)
}

public func when(fulfilled promises: [Promise<Void>]) -> Promise<Void> {
    return _when(promises)
}

public func when<U, V>(fulfilled pu: Promise<U>, _ pv: Promise<V>) -> Promise<(U, V)> {
    return _when([pu.asVoid(), pv.asVoid()]).then(on: zalgo) { (pu.value!, pv.value!) }
}

public func when<U, V, X>(fulfilled pu: Promise<U>, _ pv: Promise<V>, _ px: Promise<X>) -> Promise<(U, V, X)> {
    return _when([pu.asVoid(), pv.asVoid(), px.asVoid()]).then(on: zalgo) { (pu.value!, pv.value!, px.value!) }
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

     when(generator, concurrently: 3).then { datum: [Data] -> Void in
         // ...
     }

 - Warning: Refer to the warnings on `when(fulfilled:)`
 - Parameter promiseGenerator: Generator of promises.
 - Returns: A new promise that resolves when all the provided promises fulfill or one of the provided promises rejects.
 - SeeAlso: `when(resolved:)`
 */

public func when<T, PromiseIterator: IteratorProtocol>(fulfilled promiseIterator: PromiseIterator, concurrently: Int) -> Promise<[T]> where PromiseIterator.Element == Promise<T> {

    guard concurrently > 0 else {
        return Promise(error: PMKError.whenConcurrentlyZero)
    }

    var generator = promiseIterator
    var root = Promise<[T]>.pending()
    var pendingPromises = 0
    var promises: [Promise<T>] = []

    let barrier = DispatchQueue(label: "org.promisekit.barrier.when", attributes: [.concurrent])

    func dequeue() {
        guard root.promise.isPending else { return }  // don’t continue dequeueing if root has been rejected

        var shouldDequeue = false
        barrier.sync {
            shouldDequeue = pendingPromises < concurrently
        }
        guard shouldDequeue else { return }

        var index: Int!
        var promise: Promise<T>!

        __dispatch_barrier_sync(barrier) {
            guard let next = generator.next() else { return }

            promise = next
            index = promises.count

            pendingPromises += 1
            promises.append(next)
        }

        func testDone() {
            barrier.sync {
                if pendingPromises == 0 {
                    root.fulfill(promises.flatMap{ $0.value })
                }
            }
        }

        guard promise != nil else {
            return testDone()
        }

        promise.state.pipe { resolution in
            __dispatch_barrier_sync(barrier) {
                pendingPromises -= 1
            }

            switch resolution {
            case .fulfilled:
                dequeue()
                testDone()
            case .rejected(let error, let token):
                token.consumed = true
                root.reject(error)
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

 - Returns: A new promise that resolves once all the provided promises resolve.
 - Warning: The returned promise can *not* be rejected.
 - Note: Any promises that error are implicitly consumed, your UnhandledErrorHandler will not be called.
*/
public func when<T>(resolved promises: Promise<T>...) -> Promise<[Result<T>]> {
    return when(resolved: promises)
}

public func when<T>(resolved promises: [Promise<T>]) -> Promise<[Result<T>]> {
    guard !promises.isEmpty else { return Promise(value: []) }

    var countdown = promises.count
    let barrier = DispatchQueue(label: "org.promisekit.barrier.join", attributes: .concurrent)

    return Promise { fulfill, reject in
        for promise in promises {
            promise.state.pipe { resolution in
                if case .rejected(_, let token) = resolution {
                    token.consumed = true  // all errors are implicitly consumed
                }
                var done = false
                __dispatch_barrier_sync(barrier) {
                    countdown -= 1
                    done = countdown == 0
                }
                if done {
                    fulfill(promises.map { Result($0.state.get()!) })
                }
            }
        }
    }
}
/**
 Create a new pending promise by wrapping another asynchronous system.

 This initializer is convenient when wrapping asynchronous systems that
 use common patterns. For example:

     func fetchKitten() -> Promise<UIImage> {
         return PromiseKit.wrap { resolve in
             KittenFetcher.fetchWithCompletionBlock(resolve)
         }
     }

 - SeeAlso: Promise.init(resolvers:)
*/
public func wrap<T>(_ body: (@escaping (T?, Error?) -> Void) throws -> Void) -> Promise<T> {
    return Promise { fulfill, reject in
        try body { obj, err in
            if let obj = obj {
                fulfill(obj)
            } else if let err = err {
                reject(err)
            } else {
                reject(PMKError.invalidCallingConvention)
            }
        }
    }
}

public func wrap<T>(_ body: (@escaping (T, Error?) -> Void) throws -> Void) -> Promise<T>  {
    return Promise { fulfill, reject in
        try body { obj, err in
            if let err = err {
                reject(err)
            } else {
                fulfill(obj)
            }
        }
    }
}

public func wrap<T>(_ body: (@escaping (Error?, T?) -> Void) throws -> Void) -> Promise<T> {
    return Promise { fulfill, reject in
        try body { err, obj in
            if let obj = obj {
                fulfill(obj)
            } else if let err = err {
                reject(err)
            } else {
                reject(PMKError.invalidCallingConvention)
            }
        }
    }
}

public func wrap(_ body: (@escaping (Error?) -> Void) throws -> Void) -> Promise<Void> {
    return Promise { fulfill, reject in
        try body { error in
            if let error = error {
                reject(error)
            } else {
                fulfill()
            }
        }
    }
}

public func wrap<T>(_ body: (@escaping (T) -> Void) throws -> Void) -> Promise<T> {
    return Promise { fulfill, _ in
        try body(fulfill)
    }
}

/**
 `zalgo` causes your handlers to be executed as soon as their promise resolves.

 Usually all handlers are dispatched to a queue (the main queue by default); the `on:` parameter of `then` configures this. Its default value is `DispatchQueue.main`.

 - Important: `zalgo` is dangerous.

    Compare:

       var x = 0
       foo.then {
           print(x)  // => 1
       }
       x++

    With:

       var x = 0
       foo.then(on: zalgo) {
           print(x)  // => 0 or 1
       }
       x++
 
    In the latter case the value of `x` may be `0` or `1` depending on whether `foo` is resolved. This is a race-condition that is easily avoided by not using `zalgo`.

 - Important: you cannot control the queue that your handler executes if using `zalgo`.

 - Note: `zalgo` is provided for libraries providing promises that have good tests that prove “Unleashing Zalgo” is safe. You can also use it in your application code in situations where performance is critical, but be careful: read the essay liked below to understand the risks.

 - SeeAlso: [Designing APIs for Asynchrony](http://blog.izs.me/post/59142742143/designing-apis-for-asynchrony)
 - SeeAlso: `waldo`
 */
public let zalgo = DispatchQueue(label: "Zalgo")

/**
 `waldo` is dangerous.

 `waldo` is `zalgo`, unless the current queue is the main thread, in which
 case we dispatch to the default background queue.

 If your block is likely to take more than a few milliseconds to execute,
 then you should use waldo: 60fps means the main thread cannot hang longer
 than 17 milliseconds: don’t contribute to UI lag.

 Conversely if your then block is trivial, use zalgo: GCD is not free and
 for whatever reason you may already be on the main thread so just do what
 you are doing quickly and pass on execution.

 It is considered good practice for asynchronous APIs to complete onto the
 main thread. Apple do not always honor this, nor do other developers.
 However, they *should*. In that respect waldo is a good choice if your
 then is going to take some time and doesn’t interact with the UI.

 Please note (again) that generally you should not use `zalgo` or `waldo`.
 The performance gains are neglible and we provide these functions only out
 of a misguided sense that library code should be as optimized as possible.
 If you use either without tests proving their correctness you may
 unwillingly introduce horrendous, near-impossible-to-trace bugs.

 - SeeAlso: `zalgo`
 */
public let waldo = DispatchQueue(label: "Waldo")


@inline(__always) func contain_zalgo(_ q: DispatchQueue, body: @escaping () -> Void) {
    if q === zalgo || q === waldo && !Thread.isMainThread {
        body()
    } else {
        q.async(execute: body)
    }
}

@inline(__always) func contain_zalgo<T>(_ q: DispatchQueue, rejecter reject: @escaping (Resolution<T>) -> Void, block: @escaping () throws -> Void) {
    contain_zalgo(q) {
        do { try block() } catch { reject(Resolution(error)) }
    }
}
