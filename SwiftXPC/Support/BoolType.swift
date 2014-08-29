//
//  BoolType.swift
//  SwiftXPC
//
//  Created by C.W. Betts on 8/29/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

extension XPCBool: BooleanLiteralConvertible, BooleanType {
	public class func convertFromBooleanLiteral(value: Bool) -> XPCBool {
        return XPCBool(value: value)
	}
	
	public var boolValue: Bool {
    get {
        return value
    }
    }
}
