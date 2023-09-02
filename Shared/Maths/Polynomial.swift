//
//  Polynomial.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 01.07.2021..
//

import Foundation

struct Polynomial: Function {
    struct Term: Identifiable {
        let id: Int
        let coefficient: Double
    }

    ///  The order of each coefficient increases from 0 to N, with N being the order of the polynomial
    var terms: [Term]

    func callAsFunction(_ x: Double...) -> Double {
        var y: Double = 0
        for (index, t) in terms.enumerated() {
            y += t.coefficient * pow(x[0], Double(index))
        }
        return y
    }
}
