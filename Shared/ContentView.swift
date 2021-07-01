//
//  ContentView.swift
//  Shared
//
//  Created by Borja Arias Drake on 31.05.2021..
//

import SwiftUI
import ComplexModule

struct Polynomial {
    
    ///  The order of each coefficient increases from 0 to N, with N being the order of the polynomial
    var coefficients: [Double]
    
    func callAsFunction(_ x: Double) -> Double {
        var y: Double = 0
        for (index, c) in coefficients.enumerated() {
            y += c * pow(x, Double(index))
        }
        return y
    }
}

struct PolynomialPath: Shape {
    
    let polynomial: Polynomial
    let xRange: Range<Double>
    let unitToPointScale: Double
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: xRange.lowerBound, y: polynomial(xRange.lowerBound)))
            for x in stride(from: xRange.lowerBound, through: xRange.upperBound, by: 0.01) {
                
                /*
                 * The rect's origin is the top-left corner with the positive y-axis goind down.
                 * To draw around the center of the rect we need to:
                 *  1. Scale the points to be aligned with the grid.
                 *  2. Offset it.
                 *  3. Invert y-axis values.                 
                 */
                let xOffset = (rect.width / 2)
                let yOffset = (rect.height / 2)
                let px = x * unitToPointScale + xOffset
                let py = -polynomial(x) * unitToPointScale + yOffset
                p.addLine(to: CGPoint(x: px, y: py))
            }
        }
    }
}

struct CoordinateSystem: View {
        
    /// In points
    private let distanceBetweenMarks: CGFloat = 50
    
    private let axisLineWidth: CGFloat = 1
    
    var body: some View {
        ZStack {
            // Grid
            HorizontalMarks(distance: distanceBetweenMarks)
                .stroke(Color.blue.opacity(0.2), style: StrokeStyle(lineWidth: axisLineWidth, lineCap: .round, lineJoin: .miter, miterLimit: 10, dash: [5,5], dashPhase: 0))

            VerticalMarks(distance: distanceBetweenMarks)
                .stroke(Color.blue.opacity(0.2), style: StrokeStyle(lineWidth: axisLineWidth, lineCap: .round, lineJoin: .miter, miterLimit: 10, dash: [5,5], dashPhase: 0))

            // Axes
            HorizontalMarks(distance: distanceBetweenMarks, markLength: 10)
                .stroke(lineWidth: axisLineWidth)

            VerticalMarks(distance: distanceBetweenMarks, markLength: 10)
                .stroke(lineWidth: axisLineWidth)

            // Functions
            PolynomialPath(polynomial: Polynomial(coefficients: [0, 0, 1, 1]), xRange: (-15.0..<15.0), unitToPointScale: distanceBetweenMarks)
                .stroke(Color.pink, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .miter, miterLimit: 0, dash: [], dashPhase: 0))

            PolynomialPath(polynomial: Polynomial(coefficients: [0, 0, 0.4]), xRange: (-15.0..<15.0), unitToPointScale: distanceBetweenMarks)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .miter, miterLimit: 0, dash: [], dashPhase: 0))


            
        }
        .unitLength(distanceBetweenMarks)
    }
    
    struct HorizontalMarks: Shape {
        let distance: CGFloat
        let markLength: CGFloat?
        
        init(distance: CGFloat = 50, markLength: CGFloat? = nil) {
            self.distance = distance
            self.markLength = markLength
        }
            
        func path(in rect: CGRect) -> Path {
            Path { p in
                // Draw the axis line
                p.move(to: CGPoint(x: 0, y: rect.midY))
                p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
                let center = CGPoint(x: rect.minX, y: rect.midY)
                
                // Positive marks
                addMarks(toPath: &p,
                         offsetStart: rect.midX,
                         offsetEnd: rect.maxX,
                         center: center,
                         markLength: markLength ?? rect.height,
                         axis: .horizontal,
                         fixedAxisValue: rect.midY,
                         offsetModifier: { $0 + distance },
                         continueIterating: { $0 < rect.maxX })

                // Negative marks
                addMarks(toPath: &p,
                         offsetStart: rect.midX,
                         offsetEnd: rect.minX,
                         center: center,
                         markLength: markLength ?? rect.height,
                         axis: .horizontal,
                         fixedAxisValue: rect.midY,
                         offsetModifier: { $0 - distance },
                         continueIterating: { $0 > rect.minX })
            }
        }
    }

    struct VerticalMarks: Shape {
        let distance: CGFloat
        let markLength: CGFloat?
        
        init(distance: CGFloat = 50, markLength: CGFloat? = nil) {
            self.distance = distance
            self.markLength = markLength
        }

        func path(in rect: CGRect) -> Path {
            Path { p in
                // Draw the axis line
                p.move(to: CGPoint(x: rect.midX, y: rect.minY))
                p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
                let center = CGPoint(x: rect.minX, y: rect.midY)
                
                // Positive marks
                addMarks(toPath: &p,
                         offsetStart: rect.midY,
                         offsetEnd: rect.minY,
                         center: center,
                         markLength: markLength ?? rect.width,
                         axis: .vertical,
                         fixedAxisValue: rect.midX,
                         offsetModifier: { $0 - distance },
                         continueIterating: { $0 > rect.minY })

                // Negative marks
                addMarks(toPath: &p,
                         offsetStart: rect.midY,
                         offsetEnd: rect.maxY,
                         center: center,
                         markLength: markLength ?? rect.width,
                         axis: .vertical,
                         fixedAxisValue: rect.midX,
                         offsetModifier: { $0 + distance },
                         continueIterating: { $0 < rect.maxY })
            }
        }
    }
}

typealias OffsetModifierFunction = (CGFloat) -> (CGFloat)
typealias ContinueIteratingFunction = (CGFloat) -> (Bool)
enum BidimensionalAxis { case vertical, horizontal }

func addMarks(toPath p: inout Path,
              offsetStart: CGFloat,
              offsetEnd: CGFloat,
              center: CGPoint,
              markLength: CGFloat,
              axis: BidimensionalAxis,
              fixedAxisValue: CGFloat,
              offsetModifier: OffsetModifierFunction,
              continueIterating: ContinueIteratingFunction) {
    var offset: CGFloat = offsetStart
    p.move(to: center)
    while continueIterating(offset) {
        // Draw the mark
        let xa, xb, ya, yb: CGFloat
        let fixedAxisValueMin = fixedAxisValue - markLength/2
        let fixedAxisValueMax = fixedAxisValue + markLength/2
        
        switch axis {
            case .horizontal:
                xa = offset
                xb = offset
                ya = fixedAxisValueMin
                yb = fixedAxisValueMax

            case .vertical:
                xa = fixedAxisValueMin
                xb = fixedAxisValueMax
                ya = offset
                yb = offset
        }
        
        p.move(to: CGPoint(x: xa, y: ya))
        p.addLine(to: CGPoint(x: xb, y: yb))
        offset = offsetModifier(offset)
    }
}

struct ContentView: View {
    var body: some View {
        CoordinateSystem()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
