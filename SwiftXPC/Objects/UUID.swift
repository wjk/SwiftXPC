//
//  UUID.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

private let UUIDLength: UInt = (128 / 8)

public final class XPCUUID : XPCObject {
    public convenience init(UUID: NSUUID) {
        self.init(nativePointer: XPCShimCreateObjectFromUUID(UUID))
    }
    
    public convenience init(UUIDString: String) {
        self.init(UUID: NSUUID(UUIDString: UUIDString))
    }
    
    public var UUID: NSUUID {
    get {
        return XPCShimGetUUIDFromObject(objectPointer)
    }
    }
    
    public var stringValue: String {
    get {
        return UUID.UUIDString
    }
    }
    
    public class func generateUUID() -> XPCUUID {
        return XPCUUID(UUID: NSUUID.UUID())
    }
}
