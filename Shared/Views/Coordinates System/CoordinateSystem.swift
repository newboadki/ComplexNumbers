//
//  CoordinateSystem.swift
//  Shared
//
//  Created by Borja Arias Drake on 31.05.2021..
//

import ComplexModule
import SwiftUI

let cuadratic = Polynomial(terms: [Polynomial.Term(id: 0, coefficient: 0),
                                   Polynomial.Term(id: 1, coefficient: 0),
                                   Polynomial.Term(id: 2, coefficient: 0.4)])
let cubic = Polynomial(terms: [Polynomial.Term(id: 0, coefficient: 0),
                               Polynomial.Term(id: 1, coefficient: 0),
                               Polynomial.Term(id: 2, coefficient: 1),
                               Polynomial.Term(id: 3, coefficient: 1)])
let r15 = (-50.0 ..< 50.0)

struct CoordinateSystem: View {
    /// In points. One points equates to x points on the screen.
    private let unitToPointsScale: CGFloat = 50

    private let axisLineWidth: CGFloat = 1

    @ObservedObject var presenter: CoordinateSystemPresenter<Polynomial>

    var body: some View {
        ZStack {
            // Grid
            HorizontalMarks(distance: unitToPointsScale)
                .stroke(Color.blue.opacity(0.2), style: StrokeStyle(lineWidth: axisLineWidth, lineCap: .round, lineJoin: .miter, miterLimit: 10, dash: [5, 5], dashPhase: 0))

            VerticalMarks(distance: unitToPointsScale)
                .stroke(Color.blue.opacity(0.2), style: StrokeStyle(lineWidth: axisLineWidth, lineCap: .round, lineJoin: .miter, miterLimit: 10, dash: [5, 5], dashPhase: 0))

            // Axes
            HorizontalMarks(distance: unitToPointsScale, markLength: 10)
                .stroke(lineWidth: axisLineWidth)

            VerticalMarks(distance: unitToPointsScale, markLength: 10)
                .stroke(lineWidth: axisLineWidth)

            // Functions
            FunctionView(f: Log(base: 2),
                         xRangeInUnits: r15,
                         unitToPointScale: unitToPointsScale,
                         color: .pink)

            FunctionView(f: presenter.function,
                         xRangeInUnits: r15,
                         unitToPointScale: unitToPointsScale,
                         color: .green)

            HorizontalNumbers(unitToPointsScale: unitToPointsScale)
            VerticalNumbers(unitToPointsScale: unitToPointsScale)
        }
        .unitLength(unitToPointsScale)
        .ignoresSafeArea()
        .onAppear {
            self.presenter.bind()
        }
        .onDisappear {
            self.presenter.unbind()
        }
    }

    struct HorizontalMarks: Shape {
        let unitToPointsScale: CGFloat
        let markLength: CGFloat?

        init(distance: CGFloat = 50, markLength: CGFloat? = nil) {
            unitToPointsScale = distance
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
                         offsetModifier: { $0 + unitToPointsScale },
                         continueIterating: { $0 < rect.maxX })

                // Negative marks
                addMarks(toPath: &p,
                         offsetStart: rect.midX,
                         offsetEnd: rect.minX,
                         center: center,
                         markLength: markLength ?? rect.height,
                         axis: .horizontal,
                         fixedAxisValue: rect.midY,
                         offsetModifier: { $0 - unitToPointsScale },
                         continueIterating: { $0 > rect.minX })
            }
        }
    }

    struct VerticalMarks: Shape {
        let unitToPointsScale: CGFloat
        let markLength: CGFloat?

        init(distance: CGFloat = 50, markLength: CGFloat? = nil) {
            unitToPointsScale = distance
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
                         offsetModifier: { $0 - unitToPointsScale },
                         continueIterating: { $0 > rect.minY })

                // Negative marks
                addMarks(toPath: &p,
                         offsetStart: rect.midY,
                         offsetEnd: rect.maxY,
                         center: center,
                         markLength: markLength ?? rect.width,
                         axis: .vertical,
                         fixedAxisValue: rect.midX,
                         offsetModifier: { $0 + unitToPointsScale },
                         continueIterating: { $0 < rect.maxY })
            }
        }
    }

    struct HorizontalNumbers: View {
        let unitToPointsScale: CGFloat

        var body: some View {
            Color.clear.background(GeometryReader { g in
                let count = (g.size.width / unitToPointsScale)
                Group {
                    ForEach(0 ..< Int(count)) { i in
                        Text("\(i)").offset(x: g.size.width / 2 - 5 + CGFloat(i) * unitToPointsScale, y: g.size.height / 2 + 10)
                    }
                }

                Group {
                    ForEach(0 ..< Int(count)) { i in
                        let xOffset = g.size.width / 2 - 5 - CGFloat(i) * unitToPointsScale
                        if xOffset > 0 {
                            Text("\(-i)").offset(x: xOffset, y: g.size.height / 2 + 10)
                        }
                    }
                }
            })
        }
    }

    struct VerticalNumbers: View {
        let unitToPointsScale: CGFloat

        var body: some View {
            Color.clear.background(GeometryReader { g in
                let count = (g.size.width / unitToPointsScale)
                Group {
                    ForEach(0 ..< Int(count)) { i in
                        let yOffset = g.size.height / 2 - 10 + CGFloat(i) * unitToPointsScale
                        if (i != 0) && (yOffset < g.size.height) {
                            Text("\(-i)")
                                .offset(x: g.size.width / 2 + 10,
                                        y: yOffset)
                        }
                    }
                }

                Group {
                    ForEach(0 ..< Int(count)) { i in
                        if i != 0 {
                            Text("\(i)").offset(x: g.size.width / 2 + 10, y: g.size.height / 2 - 10 - CGFloat(i) * unitToPointsScale)
                        }
                    }
                }
            })
        }
    }
}

private typealias OffsetModifierFunction = (CGFloat) -> (CGFloat)
private typealias ContinueIteratingFunction = (CGFloat) -> (Bool)
private enum BidimensionalAxis { case vertical, horizontal }

private func addMarks(toPath p: inout Path,
                      offsetStart: CGFloat,
                      offsetEnd _: CGFloat,
                      center: CGPoint,
                      markLength: CGFloat,
                      axis: BidimensionalAxis,
                      fixedAxisValue: CGFloat,
                      offsetModifier: OffsetModifierFunction,
                      continueIterating: ContinueIteratingFunction)
{
    var offset: CGFloat = offsetStart
    p.move(to: center)
    while continueIterating(offset) {
        // Draw the mark
        let xa, xb, ya, yb: CGFloat
        let fixedAxisValueMin = fixedAxisValue - markLength / 2
        let fixedAxisValueMax = fixedAxisValue + markLength / 2

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

// struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoordinateSystem(presenter: CoordinateSystemPresenter<Polynomial>(dataSource:
//    ()))
//    }
// }
