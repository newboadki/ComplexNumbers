//
//  CoordinateSystemUnitLengthEvironmentKey.swift
//  ComplexNumbers
//
//  Created by Borja Arias Drake on 29.06.2021..
//

import SwiftUI

struct UnitLengthKey: EnvironmentKey {
    static var defaultValue: CGFloat = 10
}

extension EnvironmentValues {
    var unitLength: CGFloat {
        get { self[UnitLengthKey.self] }
        set { self[UnitLengthKey] = newValue }
    }
}

extension View {
    func unitLength(_ value: CGFloat) -> some View {
        environment(\.unitLength, value)
    }
}
