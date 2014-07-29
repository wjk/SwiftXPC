//
//  TransportErrors.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation

public final class XPCConnectionErrors {
    public class var connectionInterrupted : XPCDictionary {
        get {
            return XPCDictionary(nativePointer: XPCShimGetConnectionInterruptedError())
        }
    }
    
    public class var connectionInvalid : XPCDictionary {
        get {
            return XPCDictionary(nativePointer: XPCShimGetConnectionInvalidError())
        }
    }
    
    public class var terminationImminent : XPCDictionary {
        get {
            return XPCDictionary(nativePointer: XPCShimGetTerminationImminentError())
        }
    }
}
