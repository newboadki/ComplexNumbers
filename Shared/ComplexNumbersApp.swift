//
//  ComplexNumbersApp.swift
//  Shared
//
//  Created by Borja Arias Drake on 31.05.2021..
//

import SwiftUI
import Resolver

@main
struct ComplexNumbersApp: App {

    var body: some Scene {
        WindowGroup {
            ContainerView(presenter: Resolver.resolve(),
                          coordinateSytemPresenter: Resolver.resolve())
        }
    }
}
