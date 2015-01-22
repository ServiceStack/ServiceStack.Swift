// Original by Erica Sadun
// Source: http://ericasadun.com/2014/06/24/swift-reflection-dump/

import UIKit
import Foundation

func typestring(x : Any) -> String
{
    if let tp = x as? TypeString {
        return tp.description
    }
    
    switch x {
    case is CFString: return "CFString"
    case is Double: return "Double"
    case is Int: return "Int"
    case is Bool: return "Bool"
    case is String: return "String"
    default: break
    }
    
    switch x {
    case is [Double]: return "[Double]"
    case is [Int]: return "[Int]"
    case is [Bool]: return "[Bool]"
    case is [String]: return "[String]"
    default: break
    }
    
    switch x {
    case is Int.Type: return "Int"
//    case is CFString.Type: return "CFString" //Returns true for every type!!
    default: break
    }
    
    var mi = reflect(x)
    
    switch mi.value {
    case _ as Int.Type: return "Int"
    case _ as Double.Type: return "Double"
    case _ as Bool.Type: return "Bool"
    case _ as String.Type: return "String"
    
    case _ as Optional<Int>.Type: return "Int?"
    case _ as Optional<Double>.Type: return "Double?"
    case _ as Optional<Bool>.Type: return "Bool?"
    case _ as Optional<String>.Type: return "String?"
	
    case let a as AnyObject.Type:
        if let c: AnyClass = x as? AnyClass {
//            println(mi.valueType)
            return sanitize(NSStringFromClass(c) as String)
        }
    default: break
    }
    
    if let obj = x as? NSObject {
        return sanitize(NSStringFromClass((x as NSObject).dynamicType))
    }
    
    if mi.disposition == .Optional {
        if let value = unwrap(x) {
//            println("x: \(x) value:\(value)")
            return typestring(value) + "?"
        }
    }
    
    return sanitize(_stdlib_demangleName(_stdlib_getTypeName(x)))
}

func sanitize(name:String) -> String {
    switch name {
    case "__NSCFString": return "CFString"
    default: return name
    }
}

func unwrap(any:Any) -> Any? {
    let mi:MirrorType = reflect(any)
    if mi.disposition != .Optional {
        return any
    }
    if mi.count == 0 { return nil } // Optional.None
    let (name,some) = mi[0]
    return some.value
}

func dispositionString(disposition : MirrorDisposition) -> String
{
    switch disposition {
        case .Aggregate: return "Aggregate"
        case .Class: return "Class"
        case .Container: return "Container"
        case .Enum: return "Enum"
        case .IndexContainer : return "Index Container (Array)"
        case .KeyContainer : return "Key Container (Dict)"
        case .MembershipContainer : return "Membership Container"
        case .ObjCObject : return "ObjC Object"
        case .Optional : return "Optional"
        case .Struct: return "Struct"
        case .Tuple: return "Tuple"
    }
}

func tupleDisposition(mirror : MirrorType) -> String
{
    if (mirror.disposition != .Tuple) {return ""}
    var array = [String]()
    for reference in 0..<mirror.count {
        let (name, referenceMirror) = mirror[reference]
        array += [typestring(referenceMirror.value)]
    }
    return array.reduce(""){"\($0),\($1)"}
}

func explore(mirror : MirrorType, _ indent:Int = 0)
{
    // dump(mirror.value) // useful
    
    let indentString = String(count: indent, repeatedValue: " " as Character)
    var ts = typestring(mirror.value)
    if (mirror.disposition == .Tuple) {
        ts = tupleDisposition(mirror)
    }
    println("\(indentString)Disposition: \(dispositionString(mirror.disposition)) [\(ts)]")
    println("\(indentString)Identifier: \(mirror.objectIdentifier)")
    println("\(indentString)ValueType: \(mirror.valueType)")
    println("\(indentString)Value: \(mirror.value)")
    println("\(indentString)Summary: \(mirror.summary)")
    
    for reference in 0..<mirror.count {
        let (name, subreference) = mirror[reference]
        println("\(indentString)Element Name: \(name)")
        explore(subreference, indent + 4)
    }
}

func explore<T>(item : T)
{
    println("---------------------")
    println("Exploring \(item)")
    println("---------------------")
    
    explore(reflect(item))
    println()
}
