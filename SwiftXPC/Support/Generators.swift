//
//  Generators.swift
//  SwiftXPC
//
//  Created by C.W. Betts on 8/29/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation
import XPC

public struct XPCArrayGenerator: GeneratorType {
	private let theArray: XPCArray
	private var status: Int
	public init(array: XPCArray) {
		status = 0
		theArray = array
	}
	
	mutating public func next() -> XPCObject? {
		if status >= theArray.count {
			return nil
		} else {
			return theArray[status++]
		}
	}
}

extension XPCArray: SequenceType {
	public func generate() -> XPCArrayGenerator {
		return XPCArrayGenerator(array: self)
	}
}
