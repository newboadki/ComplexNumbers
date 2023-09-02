//
//  Log.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 17.07.2021..
//

import Foundation

struct Log: Function {
    let base: Double

    func callAsFunction(_ x: Double...) -> Double {
        precondition(x.count == 1)
        let argument = x[0]
        return log(argument) / log(base) // Base conversion, log's properties.
    }
}
