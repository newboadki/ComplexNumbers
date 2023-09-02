//
//  MenuPresenter.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 16.07.2021..
//

import Combine
import SwiftUI

final class MenuPresenter: ObservableObject {
    @Published var polynomial: Polynomial

    private let dataSource: CurrentPolynomialDataSource

    init(dataSource: CurrentPolynomialDataSource) {
        self.dataSource = dataSource
        polynomial = self.dataSource.function
    }

    func increaseOrder() {
        dataSource.increaseOrder()
        polynomial = dataSource.function
    }

    func decreaseOrder() {
        dataSource.decreaseOrder()
        polynomial = dataSource.function
    }

    func setCoefficient(_ value: Double, at index: Int) {
        dataSource.setCoefficient(value, at: index)
        polynomial = dataSource.function
    }
}
