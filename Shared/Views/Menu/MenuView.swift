//
//  MenuView.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 16.07.2021..
//

import SwiftUI

struct Menu: View {
    
    @ObservedObject var presenter: MenuPresenter
    
    var body: some View {
        
        VStack {
            Text("Menu")
                .font(.title)
                .fontWeight(.black)
            
            Spacer()
            
            List {
                PolynomialFormula(polynomial: presenter.polynomial)
                
                HStack {
                    Stepper("Order \(presenter.polynomial.terms.count - 1)") {
                        presenter.increaseOrder()
                         
                    } onDecrement: {
                        presenter.decreaseOrder()
                    }
                }
                
                Section {
                    ForEach(presenter.polynomial.terms.reversed()) { t in
                        HStack {
                            Text("Order: \(Int(t.id))")
                            Text("Coefficient: \(String(format:"%.1f", t.coefficient))")
                            Stepper("") {
                                self.presenter.setCoefficient(t.coefficient + 0.1, at: t.id)
                            } onDecrement: {
                                self.presenter.setCoefficient(t.coefficient - 0.1, at: t.id)
                            }
                        }
                    }
                }
            }
        }
    }
}
