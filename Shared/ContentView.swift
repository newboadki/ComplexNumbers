//
//  ContentView.swift
//  Shared
//
//  Created by Borja Arias Drake on 31.05.2021..
//

import SwiftUI
import ComplexModule


struct CoordinateSystem: View {
    var body: some View {
        ZStack {
            CoordinateXAxis(distance: 50)
                .stroke(lineWidth: 1)
            
            CoordinateYAxis(distance: 50)
                .stroke(lineWidth: 1)
        }
    }
    
    struct CoordinateXAxis: Shape {
        let distance: CGFloat
        
        init(distance: CGFloat = 50) {
            self.distance = distance
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
                         markLength: 10,
                         axis: .horizontal,
                         fixedAxisValue: rect.midY,
                         offsetModifier: { $0 + distance },
                         continueIterating: { $0 < rect.maxX })

                // Negative marks
                addMarks(toPath: &p,
                         offsetStart: rect.midX,
                         offsetEnd: rect.minX,
                         center: center,
                         markLength: 10,
                         axis: .horizontal,
                         fixedAxisValue: rect.midY,
                         offsetModifier: { $0 - distance },
                         continueIterating: { $0 > rect.minX })
            }
        }
    }

    struct CoordinateYAxis: Shape {
        let distance: CGFloat

        init(distance: CGFloat = 50) {
            self.distance = distance
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
                         markLength: 10,
                         axis: .vertical,
                         fixedAxisValue: rect.midX,
                         offsetModifier: { $0 - distance },
                         continueIterating: { $0 > rect.minY })

                // Negative marks
                addMarks(toPath: &p,
                         offsetStart: rect.midY,
                         offsetEnd: rect.maxY,
                         center: center,
                         markLength: 10,
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
