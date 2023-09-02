//
//  Application+Injection.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 21.02.2022..
//

import Resolver
import SwiftUI

enum DevelopmentEnvironment {
    case test, dev, prod
}

extension Resolver: ResolverRegistering {
    private static let sharedContainer = Resolver(child: nil)
    private static let devContainer = Resolver(child: sharedContainer)
    private static let testContainer = Resolver(child: sharedContainer)
    private static let prodContainer = Resolver(child: sharedContainer)

    private static var environment: DevelopmentEnvironment = .dev

    public static func registerAllServices() {
        switch Resolver.environment {
        case .dev:
            setupForDevelopment()
        case .test:
            setupForTesting()
        case .prod:
            setupForProduction()
        }
    }

    private static func setupSharedContainer() {
        sharedContainer.register { MenuPresenter(dataSource: Resolver.resolve()) }
        sharedContainer.register { CurrentPolynomialDataSource() }.scope(.shared)
        sharedContainer.register { CoordinateSystemPresenter<Polynomial>(dataSource: Resolver.resolve()) }
    }

    private static func setupForDevelopment() {
        Resolver.reset()
        setupSharedContainer()
        Resolver.root = devContainer
    }

    private static func setupForTesting() {
        Resolver.reset()
        setupSharedContainer()
        Resolver.root = testContainer
    }

    private static func setupForProduction() {
        Resolver.reset()
        setupSharedContainer()
        Resolver.root = prodContainer
    }
}
