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
        self.polynomial = Polynomial(coefficients: [])
    }
    
    func increaseOrder() {
        polynomial.coefficients.append(Polynomial.Coefficient(id: polynomial.coefficients.count, value: 1))
    }
    
    func decreaseOrder() {
        polynomial.coefficients.removeLast()
    }
    
    func setCoefficient(_ value: Double, at index: Int) {
        polynomial.coefficients[index] = Polynomial.Coefficient(id: index, value: value)
    }
}
