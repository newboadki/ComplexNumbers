//
//  CurrentPolynomialDataSource.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 16.07.2021..
//

import Combine

class CurrentPolynomialDataSource {
    
    @Published private(set) var polynomial: Polynomial
    
    init() {
        self.polynomial = Polynomial(terms: [])
    }
    
    func increaseOrder() {
        polynomial.terms.append(Polynomial.Term(id: polynomial.terms.count, coefficient: 1))
    }
    
    func decreaseOrder() {
        polynomial.terms.removeLast()
    }
    
    func setCoefficient(_ value: Double, at index: Int) {
        polynomial.terms[index] = Polynomial.Term(id: index, coefficient: value)
    }
}
