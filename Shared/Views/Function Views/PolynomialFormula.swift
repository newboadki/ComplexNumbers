//
//  PolynomialFormula.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 17.07.2021..
//

import SwiftUI

/// This represents a polynomial expression like x^2 + 4x +10
struct PolynomialFormula: View {
    let polynomial: Polynomial

    var body: some View {
        HStack {
            ForEach(polynomial.terms.reversed()) { t in
                PolyomialTermView(term: t)
            }
        }
    }
}

struct PolyomialTermView: View {
    let term: Polynomial.Term

    var body: some View {
        HStack {
            let sign = term.coefficient < 0 ? "-" : "+"
            Text("\(sign) \(String(format: "%.1f", fabs(term.coefficient))) \u{22C5} X")
                .background(GeometryReader { g in
                    Text("\(term.id)")
                        .offset(x: g.size.width, y: -g.size.height + 10)
                        .font(.system(size: 10))
                })
        }
    }
}

struct PolynomialFormula_Previews: PreviewProvider {
    static var previews: some View {
        PolynomialFormula(polynomial: Polynomial(terms: [Polynomial.Term(id: 1, coefficient: 0.5)]))
    }
}
