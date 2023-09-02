//
//  CurrentPolynomialDataSource.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 16.07.2021..
//

import Combine

final class CurrentPolynomialDataSource {
    @Published private(set) var function: Polynomial

    init() {
        function = Polynomial(terms: [])
    }

    func increaseOrder() {
        function.terms.append(Polynomial.Term(id: function.terms.count, coefficient: 1))
    }

    func decreaseOrder() {
        if !function.terms.isEmpty {
            function.terms.removeLast()
        }
    }

    func setCoefficient(_ value: Double, at index: Int) {
        function.terms[index] = Polynomial.Term(id: index, coefficient: value)
    }
}
