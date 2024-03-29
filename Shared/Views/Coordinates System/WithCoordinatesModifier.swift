//
//  WithCoordinatesModifier.swift
//  ComplexNumbers
//
//  Created by Borja Arias Drake on 29.06.2021..
//

import SwiftUI

extension View {
    func withCoordinates(x: CGFloat, y: CGFloat) -> some View {
        modifier(WithCoordinates(x: x, y: y))
    }
}

struct WithCoordinates: ViewModifier {
    // UnitLengthInPoints, this should be renamed for clarity and for consistency because the concept is also used in other places of the codebase.
    @Environment(\.unitLength) private var unitLength: CGFloat
    private let x, y: CGFloat

    init(x: CGFloat, y: CGFloat) {
        self.x = x
        self.y = y
    }

    func body(content: Content) -> some View {
        content.offset(x: x * unitLength,
                       y: -y * unitLength)
    }
}
