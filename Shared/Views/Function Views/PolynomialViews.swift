//
//  PolynommialViews.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 01.07.2021..
//

import SwiftUI

struct PolynomialPath: Shape {
    
    let polynomial: Polynomial
    let xRangeInUnits: Range<Double>
    let unitToPointScale: Double
        
    func path(in rect: CGRect) -> Path {
        Path { p in
           
            for x in stride(from: xRangeInUnits.lowerBound, through: xRangeInUnits.upperBound, by: 0.01) {
                /*
                 * The rect's origin is the top-left corner with the positive y-axis going down.
                 * To draw around the center of the rect we need to:
                 *  1. Scale the points to be aligned with the grid.
                 *  2. Offset it.
                 *  3. Invert y-axis values.
                 */
                
                let xOffset = (rect.width / 2)
                let yOffset = (rect.height / 2)
                let px = x * unitToPointScale + xOffset
                let py = -polynomial(x) * unitToPointScale + yOffset
                                
                // Only print if point is visible in the rect.
                if rect.contains(CGPoint(x: px, y: py)) && p.isEmpty {
                    p.move(to: CGPoint(x: px, y: py))
                }
                if !p.isEmpty {
                    p.addLine(to: CGPoint(x: px, y: py))
                }
            }
        }
    }
}

struct PolynomialView: View {

    let polynomial: Polynomial
    let xRangeInUnits: Range<Double>
    let unitToPointScale: Double
    let color: Color

    var body: some View {
        PolynomialPath(polynomial: polynomial,
                       xRangeInUnits: xRangeInUnits,
                       unitToPointScale: unitToPointScale)
            .stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .miter, miterLimit: 0, dash: [], dashPhase: 0))

    }
}
