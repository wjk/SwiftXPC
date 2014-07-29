//
//  Service.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

public final class XPCService {
    @noreturn public class func run(handler: (XPCConnection) -> ()) {
        XPCShimMain {
            ptr in
            handler(XPCConnection(nativePointer: ptr))
        }
    }
    
    // beginTransaction() and endTransaction() can be used as a "keep-alive" mechanism
    // to avoid the runtime killing an XPC service while it is performing background work.
    // You must make sure that you remember to call endTransaction(), as otherwise the
    // XPC service will *never* die. Note that you can use performTransaction() to ensure that
    // endTransaction() is called automatically.
    
    public class func beginTransaction() {
        xpc_transaction_begin()
    }
    
    public class func endTransaction() {
        xpc_transaction_end()
    }
    
    public class func performTransaction(callback: () -> ()) {
        beginTransaction()
        callback()
        endTransaction()
    }
}
