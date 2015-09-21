import Dispatch
import Foundation.NSError

public let PMKOperationQueue = NSOperationQueue()

public enum CatchPolicy {
    case AllErrors
    case AllErrorsExceptCancellation
}

/**
License: https://github.com/mxcl/PromiseKit#license
A promise represents the future value of a task.

To obtain the value of a promise we call `then`.

Promises are chainable: `then` returns a promise, you can call `then` on
that promise, which  returns a promise, you can call `then` on that
promise, et cetera.

Promises start in a pending state and *resolve* with a value to become
*fulfilled* or with an `NSError` to become rejected.

@see [PromiseKit `then` Guide](http://promisekit.org/then/)
@see [PromiseKit Chaining Guide](http://promisekit.org/chaining/)
*/
public class Promise<T> {
    let state: State
    
    public convenience init(@noescape resolvers: (fulfill: (T) -> Void, reject: (NSError) -> Void) -> Void) {
        self.init(sealant: { sealant in
            resolvers(fulfill: sealant.resolve, reject: sealant.resolve)
        })
    }
    
    public init(@noescape sealant: (Sealant<T>) -> Void) {
        var resolve: ((Resolution) -> Void)!
        state = UnsealedState(resolver: &resolve)
        sealant(Sealant(body: resolve))
    }
    
    public init(_ value: T) {
        state = SealedState(resolution: .Fulfilled(value))
    }
    
    public init(_ error: NSError) {
        unconsume(error)
        state = SealedState(resolution: .Rejected(error))
    }
    
    init(@noescape passthru: ((Resolution) -> Void) -> Void) {
        var resolve: ((Resolution) -> Void)!
        state = UnsealedState(resolver: &resolve)
        passthru(resolve)
    }
    
    public class func pendingPromise() -> (promise: Promise, fulfill: (T) -> Void, reject: (NSError) -> Void) {
        var sealant: Sealant<T>!
        let promise = Promise { sealant = $0 }
        return (promise, sealant.resolve, sealant.resolve)
    }
    
    func pipe(body: (Resolution) -> Void) {
        state.get { seal in
            switch seal {
            case .Pending(let handlers):
                handlers.append(body)
            case .Resolved(let resolution):
                body(resolution)
            }
        }
    }
    
    private convenience init<U>(when: Promise<U>, body: (Resolution, (Resolution) -> Void) -> Void) {
        self.init(passthru: { resolve in
            when.pipe{ body($0, resolve) }
        })
    }
    
    public func then<U>(on q: dispatch_queue_t = dispatch_get_main_queue(), _ body: (T) -> U) -> Promise<U> {
        return Promise<U>(when: self) { resolution, resolve in
            switch resolution {
            case .Rejected:
                resolve(resolution)
            case .Fulfilled(let value):
                contain_zalgo(q) {
                    resolve(.Fulfilled(body(value as! T)))
                }
            }
        }
    }
    
    public func then<U>(on q: dispatch_queue_t = dispatch_get_main_queue(), _ body: (T) -> Promise<U>) -> Promise<U> {
        return Promise<U>(when: self) { resolution, resolve in
            switch resolution {
            case .Rejected:
                resolve(resolution)
            case .Fulfilled(let value):
                contain_zalgo(q) {
                    body(value as! T).pipe(resolve)
                }
            }
        }
    }
    
    public func thenInBackground<U>(body: (T) -> U) -> Promise<U> {
        return then(on: dispatch_get_global_queue(0, 0), body)
    }
    
    public func thenInBackground<U>(body: (T) -> Promise<U>) -> Promise<U> {
        return then(on: dispatch_get_global_queue(0, 0), body)
    }
    
    public func error(policy policy: CatchPolicy = .AllErrorsExceptCancellation, _ body: (NSError) -> Void) {
        pipe { resolution in
            switch resolution {
            case .Fulfilled:
                break
            case .Rejected(let error):
                dispatch_async(dispatch_get_main_queue()) {
                    if policy == .AllErrors || !error.cancelled {
                        consume(error)
                        body(error)
                    }
                }
            }
        }
    }
    
    public func recover(on q: dispatch_queue_t = dispatch_get_main_queue(), _ body: (NSError) -> Promise<T>) -> Promise<T> {
        return Promise(when: self) { resolution, resolve in
            switch resolution {
            case .Rejected(let error):
                contain_zalgo(q) {
                    consume(error)
                    body(error).pipe(resolve)
                }
            case .Fulfilled:
                resolve(resolution)
            }
        }
    }
    
    public func finally(on q: dispatch_queue_t = dispatch_get_main_queue(), _ body: () -> Void) -> Promise<T> {
        return Promise(when: self) { resolution, resolve in
            contain_zalgo(q) {
                body()
                resolve(resolution)
            }
        }
    }
    
    public var value: T? {
        switch state.get() {
        case .None:
            return nil
        case .Some(.Fulfilled(let value)):
            return (value as! T)
        case .Some(.Rejected):
            return nil
        }
    }
}


public let zalgo: dispatch_queue_t = dispatch_queue_create("Zalgo", nil)

public let waldo: dispatch_queue_t = dispatch_queue_create("Waldo", nil)

func contain_zalgo(q: dispatch_queue_t, block: () -> Void) {
    if q === zalgo {
        block()
    } else if q === waldo {
        if NSThread.isMainThread() {
            dispatch_async(dispatch_get_global_queue(0, 0), block)
        } else {
            block()
        }
    } else {
        dispatch_async(q, block)
    }
}


extension Promise {
    public convenience init(error: String, code: Int = Constants.PMKUnexpectedError) {
        let error = NSError(domain: Constants.PMKErrorDomain, code: code, userInfo: [NSLocalizedDescriptionKey: error])
        self.init(error)
    }
    
    public func asAny() -> Promise<Any> {
        return Promise<Any>(passthru: pipe)
    }
    
    public func asAnyObject() -> Promise<AnyObject> {
        return Promise<AnyObject>(passthru: pipe)
    }
    
    /**
    Swift (1.2) seems to be much less fussy about Void promises.
    */
    public func asVoid() -> Promise<Void> {
        return then(on: zalgo) { _ in return }
    }
}


extension Promise: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Promise: \(state)"
    }
}

public func firstly<T>(promise: () -> Promise<T>) -> Promise<T> {
    return promise()
}

public enum ErrorPolicy {
    case AllErrors
    case AllErrorsExceptCancellation
}

extension Promise {
    public var error: NSError? {
        switch state.get() {
        case .None:
            return nil
        case .Some(.Fulfilled):
            return nil
        case .Some(.Rejected(let error)):
            return error
        }
    }
    
    public var pending: Bool {
        return state.get() == nil
    }
    
    public var resolved: Bool {
        return !pending
    }
    
    public var fulfilled: Bool {
        return value != nil
    }
    
    public var rejected: Bool {
        return error != nil
    }
}

public var PMKUnhandledErrorHandler = { (error: NSError) -> Void in
    dispatch_async(dispatch_get_main_queue()) {
        if !error.cancelled {
            NSLog("PromiseKit: Unhandled error: %@", error)
        }
    }
}

private class Consumable: NSObject {
    let parentError: NSError
    var consumed: Bool = false
    
    deinit {
        if !consumed {
            PMKUnhandledErrorHandler(parentError)
        }
    }
    
    init(parent: NSError) {
        parentError = parent.copy() as! NSError
    }
}

private var handle: UInt8 = 0

func consume(error: NSError) {
    if let pmke = objc_getAssociatedObject(error, &handle) as? Consumable {
        pmke.consumed = true
    }
}

func unconsume(error: NSError) {
    if let pmke = objc_getAssociatedObject(error, &handle) as! Consumable? {
        pmke.consumed = false
    } else {
        objc_setAssociatedObject(error, &handle, Consumable(parent: error), .OBJC_ASSOCIATION_RETAIN)
    }
}

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

private var cancelledErrorIdentifiers = Set([
    ErrorPair(Constants.PMKErrorDomain, Constants.PMKOperationCancelled),
    ErrorPair(NSURLErrorDomain, NSURLErrorCancelled)
    ])

extension NSError {
    public class func cancelledError() -> NSError {
        let info: [NSObject: AnyObject] = [NSLocalizedDescriptionKey: "The operation was cancelled"]
        return NSError(domain: Constants.PMKErrorDomain, code: Constants.PMKOperationCancelled, userInfo: info)
    }
    
    public class func registerCancelledErrorDomain(domain: String, code: Int) {
        cancelledErrorIdentifiers.insert(ErrorPair(domain, code))
    }
    
    public var cancelled: Bool {
        return cancelledErrorIdentifiers.contains(ErrorPair(domain, code))
    }
}

public class Sealant<T> {
    let handler: (Resolution) -> ()
    
    init(body: (Resolution) -> Void) {
        handler = body
    }
    
    func __resolve(obj: AnyObject) {
        switch obj {
        case is NSError:
            resolve(obj as! NSError)
        default:
            handler(.Fulfilled(obj))
        }
    }
    
    public func resolve(value: T) {
        handler(.Fulfilled(value))
    }
    
    public func resolve(error: NSError!) {
        unconsume(error)
        handler(.Rejected(error))
    }
    
    public func resolve(obj: T?, var _ error: NSError?) {
        if let obj = obj {
            handler(.Fulfilled(obj))
        } else if let error = error {
            resolve(error)
        } else {
            //FIXME couldn't get the constants from the umbrella header :(
            error = NSError(domain: Constants.PMKErrorDomain, code: /*PMKUnexpectedError*/ 1, userInfo: nil)
            resolve(error)
        }
    }
    
    public func resolve(obj: T, _ error: NSError?) {
        if error == nil {
            handler(.Fulfilled(obj))
        } else  {
            resolve(error)
        }
    }
}

enum Resolution {
    case Fulfilled(Any)    //TODO make type T when Swift can handle it
    case Rejected(NSError)
}

enum Seal {
    case Pending(Handlers)
    case Resolved(Resolution)
}

protocol State {
    func get() -> Resolution?
    func get(body: (Seal) -> Void)
}

class UnsealedState: State {
    private let barrier = dispatch_queue_create("org.promisekit.barrier", DISPATCH_QUEUE_CONCURRENT)
    private var seal: Seal
    
    func get() -> Resolution? {
        var result: Resolution?
        dispatch_sync(barrier) {
            switch self.seal {
            case .Resolved(let resolution):
                result = resolution
            case .Pending:
                break
            }
        }
        return result
    }
    
    func get(body: (Seal) -> Void) {
        var sealed = false
        dispatch_sync(barrier) {
            switch self.seal {
            case .Resolved:
                sealed = true
            case .Pending:
                sealed = false
            }
        }
        if !sealed {
            dispatch_barrier_sync(barrier) {
                switch (self.seal) {
                case .Pending:
                    body(self.seal)
                case .Resolved:
                    sealed = true  // welcome to race conditions
                }
            }
        }
        if sealed {
            body(seal)
        }
    }
    
    init(inout resolver: ((Resolution) -> Void)!) {
        seal = .Pending(Handlers())
        resolver = { resolution in
            var handlers: Handlers?
            dispatch_barrier_sync(self.barrier) {
                switch self.seal {
                case .Pending(let hh):
                    self.seal = .Resolved(resolution)
                    handlers = hh
                case .Resolved:
                    break
                }
            }
            if let handlers = handlers {
                for handler in handlers {
                    handler(resolution)
                }
            }
        }
    }
}

class SealedState: State {
    private let resolution: Resolution
    
    init(resolution: Resolution) {
        self.resolution = resolution
    }
    
    func get() -> Resolution? {
        return resolution
    }
    func get(body: (Seal) -> Void) {
        body(.Resolved(resolution))
    }
}


class Handlers: SequenceType {
    var bodies: [(Resolution)->()] = []
    
    func append(body: (Resolution)->()) {
        bodies.append(body)
    }
    
    func generate() -> IndexingGenerator<[(Resolution)->()]> {
        return bodies.generate()
    }
    
    var count: Int {
        return bodies.count
    }
}


extension Resolution: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case Fulfilled(let value):
            return "Fulfilled with value: \(value)"
        case Rejected(let error):
            return "Rejected with error: \(error)"
        }
    }
}

extension UnsealedState: CustomDebugStringConvertible {
    var debugDescription: String {
        var rv: String?
        get { seal in
            switch seal {
            case .Pending(let handlers):
                rv = "Pending with \(handlers.count) handlers"
            case .Resolved(let resolution):
                rv = "\(resolution)"
            }
        }
        return "UnsealedState: \(rv!)"
    }
}

extension SealedState: CustomDebugStringConvertible {
    var debugDescription: String {
        return "SealedState: \(resolution)"
    }
}


struct Constants {
    static let PMKErrorDomain = "PMKErrorDomain"
    static let PMKUnexpectedError = 1
    static let PMKOperationCancelled = 5
}