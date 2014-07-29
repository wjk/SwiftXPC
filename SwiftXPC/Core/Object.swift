//
//  Object.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

public class XPCObject : Hashable, Printable {
    internal var objectPointer : xpc_object_t
    
    internal init(nativePointer: xpc_object_t) {
        objectPointer = nativePointer
    }
    
    public func type() -> XPCObjectType {
        return XPCObjectType(nativePointer: xpc_get_type(objectPointer))
    }
    
    public func copy() -> XPCObject? {
        let copyPointer = xpc_copy(objectPointer)
        
        if let resolvedPointer = copyPointer {
            return XPCObject(nativePointer: resolvedPointer)
        } else {
            return nil
        }
    }
    
    public var hashValue: Int {
    get {
        return Int(xpc_hash(objectPointer))
    }
    }
    
    public var description: String {
    get {
        var nativeDesc = xpc_copy_description(objectPointer)
        let parsedDesc = String.fromCString(nativeDesc)
        free(nativeDesc)
        
        if let realDesc = parsedDesc {
            return realDesc
        } else {
            return "(description unavailable)"
        }
    }
    }
}

public func ==(lhs: XPCObject, rhs: XPCObject) -> Bool {
    return xpc_equal(lhs.objectPointer, rhs.objectPointer)
}
