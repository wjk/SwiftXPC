//
//  FileDescriptor.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

public final class XPCFileDescriptor : XPCObject {
    public convenience init(fileHandle: NSFileHandle) {
        self.init(nativePointer: xpc_fd_create(fileHandle.fileDescriptor))
    }
    
    public var fileHandle : NSFileHandle {
    get {
        return NSFileHandle(fileDescriptor: xpc_fd_dup(objectPointer), closeOnDealloc: true)
    }
    }
}
