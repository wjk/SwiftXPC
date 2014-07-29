//
//  String.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

public final class XPCString : XPCObject {
    public convenience init(string contents: String) {
        self.init(string: contents, encoding: NSUTF8StringEncoding)
    }
    
    public convenience init(string contents: String, encoding: NSStringEncoding) {
        let byteCount = contents.lengthOfBytesUsingEncoding(encoding)
        var buffer : Array<CChar> = []
        
        buffer.fill(CChar(0), desiredLength: byteCount)
        contents.getCString(&buffer, maxLength: byteCount, encoding: encoding)
        self.init(nativePointer: xpc_string_create(buffer))
    }
    
    public var length: Int {
    get {
        return Int(xpc_string_get_length(objectPointer))
    }
    }
    
    public var value: String? {
    get {
        return String.fromCString(xpc_string_get_string_ptr(objectPointer))
    }
    }
}
