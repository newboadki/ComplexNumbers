//
//  ComplexNumbersApp.swift
//  Shared
//
//  Created by Borja Arias Drake on 31.05.2021..
//

import SwiftUI

@main
struct ComplexNumbersApp: App {
    
    private static let currentPolynomialDataSource = CurrentPolynomialDataSource()
    private var menuPresenter = MenuPresenter(dataSource: currentPolynomialDataSource)
    private var coordinateSystemPresenter: CoordinateSystemPresenter<Polynomial> = CoordinateSystemPresenter<Polynomial>(dataSource: currentPolynomialDataSource)
    
    var body: some Scene {
        WindowGroup {
            ContainerView(presenter: menuPresenter,
                          coordinateSytemPresenter: coordinateSystemPresenter)
        }
    }
}
