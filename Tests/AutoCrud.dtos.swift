/* Options:
 Date: 2020-08-29 00:20:08
 SwiftVersion: 4.0
 Version: 5.93
 Tip: To override a DTO option, remove "//" prefix before updating
 BaseUrl: http://localhost:5000

 //BaseClass:
 //AddModelExtensions: True
 //AddServiceStackTypes: True
 //IncludeTypes:
 //ExcludeTypes:
 //ExcludeGenericBaseTypes: False
 //AddResponseStatus: False
 //AddImplicitVersion:
 //AddDescriptionAsComments: True
 //InitializeCollections: True
 //TreatTypesAsStrings:
 //DefaultImports: Foundation,ServiceStack
 */

import Foundation
import ServiceStack

public class AllInterfaces: IReturn, IHasVersion, IHasBearerToken, IHasSessionId, IGet {
    public typealias Return = AllInterfaces

    public required init() {}
    public var version: Int?
    public var bearerToken: String?
    public var sessionId: String?
    public var meta: [String: String] = [:]
}

// @Route("/mytables", "POST")
// @DataContract
public class CreateMyTable: IReturn, IPost {
    public typealias Return = IdResponse

    public required init() {}
    // @DataMember(Order=2)
    public var name: String?
}

// @Route("/mytables/{Id}", "DELETE")
// @DataContract
public class DeleteMyTable: IReturn, IDelete {
    public typealias Return = IdResponse

    public required init() {}
    // @DataMember(Order=1)
    public var id: Int64?
}

// @Route("/mytables/{Id}", "PATCH")
// @DataContract
public class PatchMyTable: IReturn, IPatch {
    public typealias Return = IdResponse

    public required init() {}
    // @DataMember(Order=1)
    public var id: Int64?

    // @DataMember(Order=2)
    public var name: String?
}

// @Route("/mytables/{Id}", "PUT")
// @DataContract
public class UpdateMyTable: IReturn, IPut {
    public typealias Return = IdResponse

    public required init() {}
    // @DataMember(Order=1)
    public var id: Int64?

    // @DataMember(Order=2)
    public var name: String?
}

// @DataContract
public class IdResponse {
    public required init() {}
    // @DataMember(Order=1)
    public var id: String?

    // @DataMember(Order=2)
    public var responseStatus: ResponseStatus?
}

// @DataContract
public class MyTable {
    public required init() {}
    // @DataMember(Order=1)
    public var id: Int64?

    // @DataMember(Order=2)
    public var name: String?
}

extension AllInterfaces: JsonSerializable {
    public static var typeName: String { return "AllInterfaces" }
    public static var metadata = Metadata.create([
        Type<AllInterfaces>.optionalProperty("version", get: { $0.version }, set: { $0.version = $1 }),
        Type<AllInterfaces>.optionalProperty("bearerToken", get: { $0.bearerToken }, set: { $0.bearerToken = $1 }),
        Type<AllInterfaces>.optionalProperty("sessionId", get: { $0.sessionId }, set: { $0.sessionId = $1 }),
        Type<AllInterfaces>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
    ])
}

extension CreateMyTable: JsonSerializable {
    public static var typeName: String { return "CreateMyTable" }
    public static var metadata = Metadata.create([
        Type<CreateMyTable>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
    ])
}

extension DeleteMyTable: JsonSerializable {
    public static var typeName: String { return "DeleteMyTable" }
    public static var metadata = Metadata.create([
        Type<DeleteMyTable>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
    ])
}

extension PatchMyTable: JsonSerializable {
    public static var typeName: String { return "PatchMyTable" }
    public static var metadata = Metadata.create([
        Type<PatchMyTable>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<PatchMyTable>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
    ])
}

extension UpdateMyTable: JsonSerializable {
    public static var typeName: String { return "UpdateMyTable" }
    public static var metadata = Metadata.create([
        Type<UpdateMyTable>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<UpdateMyTable>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
    ])
}

extension IdResponse: JsonSerializable {
    public static var typeName: String { return "IdResponse" }
    public static var metadata = Metadata.create([
        Type<IdResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<IdResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
    ])
}

extension MyTable: JsonSerializable {
    public static var typeName: String { return "MyTable" }
    public static var metadata = Metadata.create([
        Type<MyTable>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<MyTable>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
    ])
}
