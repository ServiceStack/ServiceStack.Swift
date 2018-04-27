## ServiceStackXcode Plugin
ServiceStackXcode is a plugin for the Xcode IDE to allow developers to easily integrate with ServiceStack servers without leaving their IDE.


### Installation
ServiceStackXcode is packaged in a simple dmg installer. The installer simply copies the plugin to Xcode's plugin directory so it is detected next time Xcode is started.

![](https://github.com/ServiceStack/Assets/raw/master/img/servicestackvs/ssxc-installer-01.png)

The installer requires administrator permissions. Also make sure Xcode is restarted before opening another project to ensure the plugin is registered correctly with Xcode.

![](https://github.com/ServiceStack/Assets/raw/master/img/servicestackvs/ssxc-installer-2.png)

### Add ServiceStack Reference

Like ServiceStackVS/XS, ServiceStackXcode adds easy way to take advantage of a ServiceStack's Native Types, but this time for Apple's Swift language.

Adding a ServiceStack reference is available from the `File` menu once the plugin is installed.

![](https://github.com/ServiceStack/Assets/raw/master/img/servicestackvs/ssxc-add-ref-1.png)

This will prompt for the base URL of the ServiceStack server and the name of the reference to create the file.

![](https://github.com/ServiceStack/Assets/raw/master/img/servicestackvs/ssxc-add-ref-dialog-1.png)

![](https://github.com/ServiceStack/Assets/raw/master/img/servicestackvs/ssxc-console-add-ref.gif)


### Update ServiceStack Reference
Once you have created a reference, updating the reference is also done from the File menu. Open the `{ReferenceName}.dtos.swift` file and select `Update ServiceStack Reference`. The menu will only be active when the `*.dtos.swift` document is your current active document.

![](https://github.com/ServiceStack/Assets/raw/master/img/servicestackvs/ssxc-dtos-3.png)

Options for the generation of the client DTOs are available from the comment block at the top of the DTOs file. For example, to tell the server to use a common base class of NSObject, the `//BaseClass:` can be changed to `BaseClass: NSObject`. Once saved, using the `Update ServiceStack Reference` menu to update the DTOs.

![](https://github.com/ServiceStack/Assets/raw/master/img/servicestackvs/ssxc-dtos-4a.png)

### JsonServiceClient.swift
When adding a ServiceStack reference for the first time, the JsonServiceClient is added to the project to give developers a simple, clean way of communicating with the ServiceStack server. For example, getting all technologies from the TechStacks demo.

```
var client = JsonServiceClient(baseUrl: "http://techstacks.io")

client.getAsync(GetAllTechnologies())
            .then(body:{(r:GetAllTechnologiesResponse) -> 
                //Handle typed response
            })
```

![](https://github.com/ServiceStack/Assets/raw/master/img/servicestackvs/ssxc-jsc-1.png)

## TechStacks iOS App

As an example to how this can be used, a native front end was created using the existing TechStacks.io API allowing users to see what technologies their favorite startup is using. 

![](https://github.com/ServiceStack/Assets/raw/master/img/apps/TechStacks/techstacks-ios-top100.png)

This application takes advantage of ServiceStackXcode and NativeTypes to build a rich UI that is typed end to end. 

![](https://github.com/ServiceStack/Assets/raw/master/img/apps/TechStacks/techstacks-ios-react.png)

The TechStacks iOS application is also leveraging AutoQuery to provide users with a search. ServiceStackXcode provides all the typed request/response objects as well as JsonServiceClient.swift making for a great developer experience.

```
func searchTechnologies(query:String) -> Promise<QueryResponse<Technology>> {
    self.search = query
    
    let request = FindTechnologies<Technology>()
    return client.getAsync(request, query:["NameContains":query, "DescriptionContains":query])
        .then(body:{(r:QueryResponse<Technology>) -> QueryResponse<Technology> in
            self.filteredTechnologies = r.results
            return r
        })
}
```
![](https://github.com/ServiceStack/Assets/raw/master/img/apps/TechStacks/techstacks-ios-search.png)


### TechStacks Desktop Application

Another TechStacks demo application was created to show that ServiceStackXcode can help for a variety of application types. 

![](https://github.com/ServiceStack/Assets/raw/master/img/apps/TechStacks/techstacks-desktop-1.png)

This application focuses on searching for technologies and who uses them by proving a more customizable search, again leveraging AutoQuery. Just by providing the properties from which to search and AutoQuery operators, we can easily create a more useful search to users by mapping them to AutoQuery convetions.

```
func searchTechStacks(query:String, field:String? = nil, operand:String? = nil) -> Promise<QueryResponse<TechnologyStack>> {
    self.search = query
    
    let queryString = query.count > 0 && field != nil && operand != nil
        ? [createAutoQueryParam(field!, operand!): query]
        : ["NameContains":query, "DescriptionContains":query]
    
    let request = FindTechStacks<TechnologyStack>()
    return client.getAsync(request, query:queryString)
        .then(body:{(r:QueryResponse<TechnologyStack>) -> QueryResponse<TechnologyStack> in
            self.filteredTechStacks = r.results
            return r
        })
}
```

![](https://github.com/ServiceStack/Assets/raw/master/img/apps/TechStacks/techstacks-desktop-2.png)
