//
//  Function.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 17.07.2021..
//

import Numerics

protocol Function {
    associatedtype R: Real
    func callAsFunction(_ x: R...) -> R
}
