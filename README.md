Follow [@ServiceStack](https://twitter.com/servicestack) or join the [Google+ Community](https://plus.google.com/communities/112445368900682590445)
for updates, or [StackOverflow](http://stackoverflow.com/questions/ask) or the [Customer Forums](https://forums.servicestack.net/) for support.

# ServiceStack.Swift

See [Swift Add ServiceStack Reference](http://docs.servicestack.net/swift-add-servicestack-reference) for an overview of the Swift Support in ServiceStack.

ServiceStack's **Add ServiceStack Reference** feature lets iOS/macOS developers easily generate an native 
typed Swift API for your ServiceStack Services using the `x` dotnet command-line tool.

## Simple command-line utils for ServiceStack

The [x dotnet tool](https://docs.servicestack.net/dotnet-tool) provides a simple command-line UX to easily Add and Update Swift ServiceStack References.

Prerequisites: Install [.NET Core](https://dotnet.microsoft.com/download).

    $ dotnet tool install --global x 

This will make the `x` dotnet tool available in your `$PATH` which can now be used from within a **Terminal window** at your Xcode project folder.

To use the latest `JsonServiceClient` you'll need to add a reference to ServiceStack Swift library using your preferred package manager:

### Xcode

From Xcode 12 the Swift Package Manager is built into Xcode.

Go to **File** > **Swift Packages** > **Add Package Dependency**:

![](https://raw.githubusercontent.com/ServiceStack/docs/master/docs/images/dev/xcode-swift-add-package.png)

Add a reference to the ServiceStack.Swift GitHub repo:

    https://github.com/ServiceStack/ServiceStack.Swift

![](https://raw.githubusercontent.com/ServiceStack/docs/master/docs/images/dev/xcode-add-servicestack-swift.png)

After adding the dependency both [ServiceStack.Swift](https://github.com/ServiceStack/ServiceStack.Swift) and its 
[PromiseKit](https://github.com/mxcl/PromiseKit) dependency will be added to your project:

![](https://raw.githubusercontent.com/ServiceStack/docs/master/docs/images/dev/xcode-servicestack-swift-added.png)

#### SwiftPM

```swift
dependencies: [
    .package(name: "ServiceStack", 
        url: "https://github.com/ServiceStack/ServiceStack.Swift.git", 
        Version(6,0,0)..<Version(7,0,0)),
],
```

#### CocoaPods

In your [Podfile](https://guides.cocoapods.org/syntax/podfile.html):

```ruby
use_frameworks!

# Pods for Project
pod "ServiceStack", '~> 6.0.2'
```

#### Carthage

```ruby
github "ServiceStack/ServiceStack.Swift" ~> 6.0.2
```

## API


```swift
public protocol ServiceClient {
    func get<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func get<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func get<T: IReturn>(_ request: T, query: [String: String]) throws -> T.Return where T: Codable
    func get<T: Codable>(_ relativeUrl: String) throws -> T
    func getAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable
    func getAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable
    func getAsync<T: IReturn>(_ request: T, query: [String: String]) async throws -> T.Return where T: Codable
    func getAsync<T: Codable>(_ relativeUrl: String) async throws -> T

    func post<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func post<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func post<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response
    func postAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable
    func postAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable
    func postAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) async throws -> Response

    func put<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func put<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func put<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response
    func putAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable
    func putAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable
    func putAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) async throws -> Response

    func delete<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func delete<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func delete<T: IReturn>(_ request: T, query: [String: String]) throws -> T.Return where T: Codable
    func delete<T: Codable>(_ relativeUrl: String) throws -> T
    func deleteAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable
    func deleteAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable
    func deleteAsync<T: IReturn>(_ request: T, query: [String: String]) async throws -> T.Return where T: Codable
    func deleteAsync<T: Codable>(_ relativeUrl: String) async throws -> T

    func patch<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func patch<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func patch<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response
    func patchAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable
    func patchAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable
    func patchAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) async throws -> Response

    func send<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func send<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func send<T: Codable>(intoResponse: T, request: URLRequest) throws -> T
    func sendAsync<T: Codable>(intoResponse: T, request: URLRequest) async throws -> T

    func postFileWithRequest<T: IReturn & Codable>(request:T, file:UploadFile) throws -> T.Return
    func postFileWithRequestAsync<T: IReturn & Codable>(request:T, file:UploadFile) async throws -> T.Return
    func postFileWithRequest<T: IReturn>(_ relativeUrl: String, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) throws -> T.Return
    func postFileWithRequestAsync<T: IReturn>(_ relativeUrl: String, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) async throws -> T.Return
    func postFileWithRequest<T: IReturn>(url:URL, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) throws -> T.Return
    func postFileWithRequestAsync<T: IReturn>(url:URL, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) async throws -> T.Return
    func postFilesWithRequest<T: IReturn & Codable>(request:T, files:[UploadFile]) throws -> T.Return
    func postFilesWithRequestAsync<T: IReturn & Codable>(request:T, files:[UploadFile]) async throws -> T.Return
    func postFilesWithRequest<T: IReturn>(url:URL, request:T, files:[UploadFile]) throws -> T.Return
    func postFilesWithRequestAsync<T: IReturn>(url:URL, request:T, files:[UploadFile]) async throws -> T.Return
    
    func putFileWithRequest<T: IReturn & Codable>(request:T, file:UploadFile) throws -> T.Return
    func putFileWithRequestAsync<T: IReturn & Codable>(request:T, file:UploadFile) async throws -> T.Return
    func putFileWithRequest<T: IReturn>(_ relativeUrl: String, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) throws -> T.Return
    func putFileWithRequestAsync<T: IReturn>(_ relativeUrl: String, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) async throws -> T.Return
    func putFileWithRequest<T: IReturn>(url:URL, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) throws -> T.Return
    func putFileWithRequestAsync<T: IReturn>(url:URL, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) async throws -> T.Return
    func putFilesWithRequest<T: IReturn & Codable>(request:T, files:[UploadFile]) throws -> T.Return
    func putFilesWithRequestAsync<T: IReturn & Codable>(request:T, files:[UploadFile]) async throws -> T.Return
    func putFilesWithRequest<T: IReturn>(url:URL, request:T, files:[UploadFile]) throws -> T.Return
    func putFilesWithRequestAsync<T: IReturn>(url:URL, request:T, files:[UploadFile]) async throws -> T.Return
    
    func sendFileWithRequest<T: IReturn>(_ req:inout URLRequest, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) throws -> T.Return
    func sendFileWithRequestAsync<T: IReturn>(_ req:inout URLRequest, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) async throws -> T.Return
    func sendFilesWithRequest<T: IReturn>(_ req:inout URLRequest, request:T, files:[UploadFile]) throws -> T.Return
    func sendFilesWithRequestAsync<T: IReturn>(_ req:inout URLRequest, request:T, files:[UploadFile]) async throws -> T.Return

    func getData(url: String) throws -> (Data, HTTPURLResponse)?
    func getDataAsync(url: String) async throws -> (Data, HTTPURLResponse)?
    func getData(request: URLRequest, retryIf:((HTTPURLResponse) -> Bool)?) throws -> (Data, HTTPURLResponse)?
    func getDataAsync(request: URLRequest, retryIf:((HTTPURLResponse) async throws -> Bool)?) async throws -> (Data, HTTPURLResponse)?

    func getCookies() -> [String:String]
    func getTokenCookie() -> String?
    func getRefreshTokenCookie() -> String?
}
```

### v6.0.5 Release

- Replaced PromiseKit with Swift Concurrency's async/await
- Added new `postFileWithRequest` and `postFilesWithRequest` sync and async APIs

### v6.0.1 Release

Added new sync and async file upload with Request APIs for POST and PUT HTTP Requests:

### v6.0.0 Release

The latest **v6** Release is now dependency-free, where its PromiseKit async APIs have been replaced to use 
[Swift's native Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/) support.

```swift
import ServiceStack

let client = JsonServiceClient(baseUrl:baseUrl)
```

#### Async

```swift
let request = Hello()
request.name = "World"

let response = try await client.postAsync(request)
print(response.result!)
```

#### Sync

```swift
let request = Hello()
request.name = "World"

let response = try client.post(request)
print(response.result!)
```

### v5.0.0 Release

The latest **v5** support for ServiceStack.Swift has been rewritten to use **Swift 5** and DTOs generated using Swift's new `Codable` 
available in ServiceStack from **v5.10.5+**.

#### Previous Version

To use a `JsonServiceStack` with DTOs generated earlier ServiceStack versions you'll need to reference the older **1.x** client version instead:

```swift
dependencies: [
    .package(name: "ServiceStack", url: "https://github.com/ServiceStack/ServiceStack.Swift.git", 
        Version(1,0,0)..<Version(2,0,0)),
],
```

### Add a new ServiceStack Reference

To Add a new ServiceStack Reference, call `x swift` with the Base URL to a remote ServiceStack instance:

    x swift {BaseUrl}
    x swift {BaseUrl} {FileName}

Where if no FileName is provided, it first uses `dtos.swift` or if it exists the filename is inferred from the host name of the remote URL, e.g:

    x swift https://techstacks.io

Downloads the Typed Swift DTOs for [techstacks.io](https://techstacks.io) and saves them to `dtos.swift`. 

Alternatively you can have it saved to a different FileName with:

    x swift https://techstacks.io TechStacks

Which instead saves the DTOs to `TechStacks.dtos.swift`.

`x swift` also downloads [ServiceStack's Swift Client](https://github.com/ServiceStack/ServiceStack.Swift) 
and saves it to `JsonServiceClient.swift` which together with the Server DTOs contains all the dependencies 
required to consume Typed Web Services in Swift.

#### Update an existing ServiceStack Reference

The easiest way to update all your Swift Server DTOs is to just call `x swift` without any arguments:

    x swift

This will go through and update all your `*.dtos.swift` Service References.

To Update a specific ServiceStack Reference, call `x swift` with the Filename:

    x swift {FileName.dtos.swift}

As an example, you can Update the Server DTOs added in the previous command with:

    x swift TechStacks.dtos.swift

Which also includes any 
[Customization Options](https://docs.servicestack.net/swift-add-servicestack-reference#swift-configuration) 
that were manually added.

### Optional DTO Customizations

Refer to [Swift Add ServiceStack Reference docs](http://docs.servicestack.net/swift-add-servicestack-reference) for info on additional customizations available.

### Swift Apps using ServiceStack.Swift

## [AutoQuery Viewer](https://github.com/ServiceStackApps/AutoQueryViewer)

AutoQuery Viewer is a native iPad App that provides an automatic UI for browsing, inspecting and querying any publicly accessible [ServiceStack AutoQuery Service](https://github.com/ServiceStack/ServiceStack/wiki/Auto-Query) from an iPad. 

[![AutoQuery Viewer on AppStore](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/wikis/autoquery/autoqueryviewer-appstore.png)](https://itunes.apple.com/us/app/autoquery-viewer/id968625288?ls=1&mt=8)

## [TechStacks iOS App](https://github.com/ServiceStackApps/TechStacksApp)

The TechStacks Native iOS App provides a fluid and responsive experience for browsing https://techstacks.io content on iPhones and iPad devices. It takes advantage of the ease-of-use and utility of [ServiceStack's new support for Swift and XCode](http://docs.servicestack.net/swift-add-servicestack-reference) for quickly building services-rich iOS Apps. [Get it now free on the AppStore!](https://itunes.apple.com/us/app/techstacks/id965680615?ls=1&mt=8)

[![TechStacks on AppStore](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/release-notes/techstacks-appstore.png)](https://itunes.apple.com/us/app/techstacks/id965680615?ls=1&mt=8)

#### Features 

 - [MVC and Key-Value Observables (KVO)](https://github.com/ServiceStackApps/TechStacksApp#mvc-and-key-value-observables-kvo)
   - [Enable Key-Value Observing in Swift DTO's](https://github.com/ServiceStackApps/TechStacksApp#enable-key-value-observing-in-swift-dtos)
   - [Observing Data Changes](https://github.com/ServiceStackApps/TechStacksApp#observing-data-changes)
 - [Images and Custom Binary Requests](https://github.com/ServiceStackApps/TechStacksApp#images-and-custom-binary-requests) 

## [TechStacks Cocoa OSX Desktop App](https://github.com/ServiceStackApps/TechStacksDesktopApp)

TechStacks OSX Desktop App is built around 2 AutoQuery Services showing how much querying functionality [AutoQuery Services](https://github.com/ServiceStack/ServiceStack/wiki/Auto-Query) provides for free and how easy they are to call with [ServiceStack's new support for Swift and XCode](https://github.com/ServiceStack/ServiceStack/wiki/Swift-Add-ServiceStack-Reference).

[![TechStack Desktop Search Fields](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/release-notes/techstacks-desktop-field.png)](https://github.com/ServiceStackApps/TechStacksDesktopApp)
