//
//  Extensions.swift
//  DOS Prompt
//
//  Created by William Kent on 7/28/14.
//  Copyright (c) 2014 William Kent. All rights reserved.
//

import Foundation

extension Array {
    internal mutating func
    fill(value: Element, desiredLength: Int) {
        for _ in 0..<desiredLength {
            self.append(value)
        }
    }
}
