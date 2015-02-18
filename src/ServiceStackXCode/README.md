## ServiceStackXcode Plugin
ServiceStackXcode is a plugin for the Xcode IDE to allow developers to easily integrate with ServiceStack servers without leaving their IDE.


### Installation
ServiceStackXcode is packaged in a simple dmg installer. The installer simply copies the plugin to Xcode's plugin directory so it is detected next time Xcode is started.

![](https://github.com/ServiceStack/Assets/raw/master/img/servicestackvs/ssxc-installer-01.png)

The installer requires administrator permissions. Also make sure Xcode is restarted before openning another project to ensure the plugin is registered correctly with Xcode.

![](https://github.com/ServiceStack/Assets/raw/master/img/servicestackvs/ssxc-installer-2.png)

### Add ServiceStack Reference

Like ServiceStackVS/XS, ServiceStackXcode adds easy way to take advantage of a ServiceStack's Native Types, but this time for Apple's Swift language.

Adding a ServiceStack reference is available from the `File` menu once the plugin is installed.

![](https://github.com/ServiceStack/Assets/raw/master/img/servicestackvs/ssxc-add-ref-1.png)

This will prompt for the base URL of the ServiceStack server and the name of the reference to create the file.

![](https://github.com/ServiceStack/Assets/raw/master/img/servicestackvs/ssxc-add-ref-dialog-1.png)

![](https://github.com/ServiceStack/Assets/raw/master/img/servicestackvs/ssxc-console-add-ref.gif)


### Update ServiceStack Reference
Once you have created a referece, updating the reference is also done from the File menu. Open the `{ReferenceName}.dtos.swift` file and select `Update ServiceStack Reference`. The menu will only be active when the `*.dtos.swift` document is your current active document.

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
