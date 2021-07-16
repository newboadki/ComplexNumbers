//
//  CoordinateSystemPresenter.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 16.07.2021..
//

import Foundation
import Combine

class CoordinateSystemPresenter: ObservableObject {
    
    @Published var polynomial: Polynomial
    private var subscription: AnyCancellable!
    
    private let dataSource: CurrentPolynomialDataSource
    
    init(dataSource: CurrentPolynomialDataSource) {
        self.dataSource = dataSource
        self.polynomial = self.dataSource.polynomial
    }
    
    public func bind() {
        self.subscription = self.dataSource.$polynomial.sink(receiveValue: { newPolynomial  in
            self.polynomial = newPolynomial
        })
    }
    
    public func unbind() {
        self.subscription.cancel()
    }
}
