//
//  SharedMemoryRegion.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

// XPCSharedMemoryRegion allocates a region of memory not less than the given length
// at time of creation. You can call the readMemory() method to get back a copy
// of the memory region. (Each time you call this method, you get a different
// address; however, the memory regions are all shared and changes to one will
// update the others.) Keep the SharedMemoryPointer instance returned in a
// variable for as long as you need to access it. When the pointer instance
// is deallocated, its backing memory will be unmapped. Note, however, that the
// data still exists until the last reference to it is destroyed; then and only
// then will it be deallocated.

public final class XPCSharedMemoryRegion : XPCObject {
    public convenience init(length: Int) {
        let region = mmap(nil, UInt(length), PROT_READ | PROT_WRITE, MAP_ANON | MAP_SHARED, -1, 0)
        let nativePointer = xpc_shmem_create(region, UInt(length))
        self.init(nativePointer: nativePointer)
        munmap(region, UInt(length))
    }
    
    public func readMemory() -> SharedMemoryPointer? {
        var size : UInt = 0
        
        let mem : UnsafeMutablePointer<UInt8> = withUnsafeMutablePointer(&size, {
            address in
            return XPCShimMapSharedMemoryRegion(self.objectPointer, address)
        })
        if mem == nil { return nil }
        
        return SharedMemoryPointer(buffer: mem, length: Int(size))
    }
}

public final class SharedMemoryPointer {
    private(set) public var memory: UnsafeMutablePointer<UInt8>
    private(set) public var size: Int
    
    internal init(buffer: UnsafeMutablePointer<UInt8>, length: Int) {
        memory = buffer
        size = 0
    }
    
    deinit {
        munmap(memory, UInt(size))
    }
}
