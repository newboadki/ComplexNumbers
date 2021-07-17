//
//  MenuPresenter.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 16.07.2021..
//

import SwiftUI
import Combine

class MenuPresenter: ObservableObject {
    
    @Published var polynomial: Polynomial
    
    private let dataSource: CurrentPolynomialDataSource
    
    init(dataSource: CurrentPolynomialDataSource) {
        self.dataSource = dataSource
        self.polynomial = self.dataSource.function
    }
    
    func increaseOrder() {
        dataSource.increaseOrder()
        self.polynomial = self.dataSource.function
    }
    
    func decreaseOrder() {
        dataSource.decreaseOrder()
        self.polynomial = self.dataSource.function
    }
    
    func setCoefficient(_ value: Double, at index: Int) {
        dataSource.setCoefficient(value, at: index)
        self.polynomial = self.dataSource.function
    }
}
