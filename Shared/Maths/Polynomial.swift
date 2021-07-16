//
//  Polynomial.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 01.07.2021..
//

import Foundation

struct Polynomial {
    
    struct Coefficient: Identifiable {
        let id: Int
        let value: Double
    }
    
    ///  The order of each coefficient increases from 0 to N, with N being the order of the polynomial
    var coefficients: [Coefficient]
    
    func callAsFunction(_ x: Double) -> Double {
        var y: Double = 0
        for (index, c) in coefficients.enumerated() {
            y += c.value * pow(x, Double(index))
        }
        return y
    }
}
