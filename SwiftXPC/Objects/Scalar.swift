//
//  Integer.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

public final class XPCNull : XPCObject {
    public convenience init() {
        self.init(nativePointer: xpc_null_create())
    }
}

public final class XPCBool : XPCObject {
    public convenience init(value: Bool) {
        self.init(nativePointer: xpc_bool_create(value))
    }
    
    public var value: Bool {
    get {
        return xpc_bool_get_value(objectPointer)
    }
    }
}

public final class XPCInt : XPCObject {
    public convenience init(value: Int) {
        self.init(nativePointer: xpc_int64_create(Int64(value)))
    }
    
    public var value: Int {
    get {
        return Int(xpc_int64_get_value(objectPointer))
    }
    }
}

public final class XPCUInt : XPCObject {
    public convenience init(value: UInt) {
        self.init(nativePointer: xpc_uint64_create(UInt64(value)))
    }
    
    public var value: UInt {
    get {
        return UInt(xpc_uint64_get_value(objectPointer))
    }
    }
}

public final class XPCDouble : XPCObject {
    public convenience init(value: Double) {
        self.init(nativePointer: xpc_double_create(value))
    }
    
    public var value: Double {
    get {
        return xpc_double_get_value(objectPointer)
    }
    }
}
