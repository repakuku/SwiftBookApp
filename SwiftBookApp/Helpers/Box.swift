//
//  Box.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/18/23.
//

import Foundation

final class Box<T> {
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
}
