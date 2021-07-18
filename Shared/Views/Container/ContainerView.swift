//
//  ContainerView.swift
//  ComplexNumbers (iOS)
//
//  Created by Borja Arias Drake on 04.07.2021..
//

import SwiftUI

struct ContainerView: View {
    
    private var presenter: MenuPresenter
    
    private var coordinateSytemPresenter: CoordinateSystemPresenter<Polynomial>
    
    init(presenter: MenuPresenter, coordinateSytemPresenter: CoordinateSystemPresenter<Polynomial>) {
        self.presenter = presenter
        self.coordinateSytemPresenter = coordinateSytemPresenter
    }
    
    var body: some View {
        GeometryReader { g in
            HStack {
                
                Menu(presenter: presenter).frame(width: g.size.width/3)
                
                CoordinateSystem(presenter: coordinateSytemPresenter).frame(width: g.size.width*2/3)
            }
        }
    }
}

struct ContainerView_previews: PreviewProvider {

    static let dataSource = CurrentPolynomialDataSource()
    
    static var previews: some View {
        ContainerView(presenter: MenuPresenter(dataSource: dataSource),
                      coordinateSytemPresenter: CoordinateSystemPresenter(dataSource: dataSource))
    }
}
