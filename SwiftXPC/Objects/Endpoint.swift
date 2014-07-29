//
//  Endpoint.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

public final class XPCEndpoint : XPCObject {
    public convenience init(connection: XPCConnection) {
        self.init(nativePointer: xpc_endpoint_create(connection.objectPointer))
    }
}
