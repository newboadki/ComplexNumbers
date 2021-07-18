//
//  CoordinateSystemPresenter.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 16.07.2021..
//

import Foundation
import Combine

class CoordinateSystemPresenter<F: Function>: ObservableObject {
    
    @Published var function: F
    private var subscription: AnyCancellable!
    
    private let dataSource: CurrentPolynomialDataSource
    
    
    init(dataSource: CurrentPolynomialDataSource) {
        self.dataSource = dataSource
        self.function = self.dataSource.function as! F
    }
    
    public func bind() {
        self.subscription = self.dataSource.$function.sink(receiveValue: { newPolynomial  in
            self.function = newPolynomial as! F
        })
    }
    
    public func unbind() {
        self.subscription.cancel()
    }
}
