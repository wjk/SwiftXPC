//
//  Dictionary.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

public final class XPCDictionary : XPCObject {
    public convenience init() {
        self.init(nativePointer: xpc_dictionary_create(nil, nil, 0))
    }
    
    public subscript(key: String) -> XPCObject {
        get {
            let byteCount = key.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
            var buffer : [CChar] = []
            buffer.fill(CChar(0), desiredLength: byteCount)
            key.getCString(&buffer, maxLength: byteCount, encoding: NSUTF8StringEncoding)
            
            return XPCObject(nativePointer: xpc_dictionary_get_value(objectPointer, buffer))
        }
        
        set {
            let byteCount = key.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
            var buffer : [CChar] = []
            buffer.fill(CChar(0), desiredLength: byteCount)
            key.getCString(&buffer, maxLength: byteCount, encoding: NSUTF8StringEncoding)
            
            xpc_dictionary_set_value(objectPointer, buffer, newValue.objectPointer)
        }
    }
    
    public var count: Int {
    get {
        return Int(xpc_dictionary_get_count(objectPointer))
    }
    }
}
