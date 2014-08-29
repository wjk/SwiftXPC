//
//  StringLiteral.swift
//  SwiftXPC
//
//  Created by C.W. Betts on 8/29/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

extension XPCString: StringLiteralConvertible {
    public class func convertFromStringLiteral(value: String) -> XPCString {
        return XPCString(string: value)
    }
    
    public class func convertFromExtendedGraphemeClusterLiteral(value: String) -> XPCString {
        let outString = String.convertFromExtendedGraphemeClusterLiteral(value)
        return XPCString(string: outString)
    }
}
