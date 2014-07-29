//
//  Connection.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

public final class XPCObjectType : Equatable {
    private let objectPointer : xpc_type_t
    
    internal init(nativePointer: xpc_type_t) {
        objectPointer = nativePointer
    }
    
    public class func connection() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetConnectionType())
    }
    
    public class func endpoint() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetEndpointType())
    }
    
    public class func activity() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetActivityType())
    }
    
    public class func nullPointer() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetNullType())
    }
    
    public class func boolean() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetBooleanType())
    }
    
    public class func integer() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetInt64Type())
    }
    
    public class func unsignedInteger() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetUInt64Type())
    }
    
    public class func floatingPoint() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetDoubleType())
    }
    
    public class func date() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetDateType())
    }
    
    public class func data() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetDataType())
    }
    
    public class func string() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetStringType())
    }
    
    public class func UUID() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetUUIDType())
    }
    
    public class func fileDescriptor() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetFileDescriptorType())
    }
    
    public class func sharedMemoryRegion() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetSharedMemoryType())
    }
    
    public class func array() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetArrayType())
    }
    
    public class func dictionary() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetDictionaryType())
    }
    
    public class func error() -> XPCObjectType {
        return XPCObjectType(nativePointer: XPCShimGetErrorType())
    }
}

public func ==(lhs: XPCObjectType, rhs: XPCObjectType) -> Bool {
    return lhs.objectPointer == rhs.objectPointer
}
