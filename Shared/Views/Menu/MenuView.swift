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
                HStack {
                    ForEach(presenter.polynomial.coefficients.reversed()) { c in
                        Text("\(String(format:"%.1f", c.value))*x^\(Int(c.id))")
                    }
                }
                
                HStack {
                    Text("\(presenter.polynomial.coefficients.count)")
                   
                    Stepper("Order") {
                        presenter.increaseOrder()
                         
                    } onDecrement: {
                        presenter.decreaseOrder()
                    }
                }
                
                Section {
                    ForEach(presenter.polynomial.coefficients.reversed()) { c in
                        HStack {
                            Text("Order: \(Int(c.id))")
                            Text("Coefficient: \(String(format:"%.1f", c.value))")
                            Stepper("") {
                                self.presenter.setCoefficient(c.value + 0.1, at: c.id)
                            } onDecrement: {
                                self.presenter.setCoefficient(c.value - 0.1, at: c.id)
                            }
                        }
                    }
                }
            }
        }
    }
}
