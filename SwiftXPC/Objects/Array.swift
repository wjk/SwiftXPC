//
//  Array.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

public final class XPCArray : XPCObject {
    public convenience init() {
        self.init(nativePointer: xpc_array_create(nil, 0))
    }
    
    public convenience init(objects: [XPCObject]) {
        self.init()
        
        for obj in objects {
            appendObject(obj)
        }
    }
    
    public func appendObject(value: XPCObject) {
        xpc_array_append_value(objectPointer, value.objectPointer)
    }
    
    public subscript(index: Int) -> XPCObject {
        get {
            let ptr = xpc_array_get_value(objectPointer, UInt(index))
            return XPCObject(nativePointer: ptr)
        }
        
        set {
            xpc_array_set_value(objectPointer, UInt(index), newValue.objectPointer)
        }
    }
    
    public var count: Int {
    get {
        return Int(xpc_array_get_count(objectPointer))
    }
    }
}
