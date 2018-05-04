#if false
//
    //  DynamicJson.swift
    //  ServiceStackClient
//
    //  Created by Demis Bellot on 1/29/15.
    //  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

    import Foundation

    // Reflection based JSON Serializer

    public class DynamicJArray {
        var sb: String

        init(string: String? = nil) {
            sb = string ?? String()
        }

        func append(value: Any) {
            append(value, mirrorType: reflect(value))
        }

        func append(value: Any, mirrorType _: MirrorType) {
            if countElements(sb) > 0 {
                sb += ","
            }
            var str: String = "null"
            if let val = DynamicJValue.unwrap(value) {
                str = DynamicJValue.toJson(val)
            }
            sb += "\(str)"
        }

        func toJson() -> String {
            return "[\(sb)]"
        }

        class func toJson(any: Any) -> String {
            return toJson(any, mirrorType: reflect(any))
        }

        class func toJson(any _: Any, mirrorType mi: MirrorType) -> String {
            var jb = DynamicJArray()

            for i in 0 ..< mi.count {
                let (name, pi) = mi[i]
                jb.append(pi.value, mirrorType: pi)
            }

            return jb.toJson()
        }
    }

    public class DynamicJObject {
        var sb: String

        init(string: String? = nil) {
            sb = string ?? String()
        }

        func append(name: String, value: Any) {
            if name == "super" { return }

            var str: String = "null"
            if let val = DynamicJValue.unwrap(value) {
                str = DynamicJValue.toJson(val)
            }

            if countElements(sb) > 0 {
                sb += ","
            }

            sb += "\"\(name)\":\(str)"
        }

        class func toJson(value: Any) -> String {
            return toJson(value, mirrorType: reflect(value))
        }

        class func toJson(value _: Any, mirrorType mi: MirrorType) -> String {
            var jb = DynamicJObject()

            for i in 0 ..< mi.count {
                let (name, pi) = mi[i]
                jb.append(name, value: pi.value)
            }

            return jb.toJson()
        }

        func toJson() -> String {
            return "{\(sb)}"
        }
    }

    public class DynamicJValue {
        class func unwrap(any: Any) -> Any? {
            let mi: MirrorType = reflect(any)
            if mi.disposition != .Optional {
                return any
            }
            if mi.count == 0 { return nil } // Optional.None
            let (name, some) = mi[0]
            return some.value
        }

        class func toJson(any: Any) -> String {
            return toJson(any, mirrorType: reflect(any))
        }

        class func toJson(any: Any, mirrorType mi: MirrorType) -> String {
            switch any {
            case let int as Int:
                return "\(int)"
            case let double as Double:
                return "\(double)"
            case let bool as Bool:
                return "\(bool)"
            case let str as String:
                return "\"\(str)\""
            default:
                switch mi.disposition {
                case .IndexContainer:
                    return DynamicJArray.toJson(any, mirrorType: mi)
                case .Class:
                    return DynamicJObject.toJson(any, mirrorType: mi)
                default:
                    return "\(any)"
                }
            }
        }
    }

#endif
