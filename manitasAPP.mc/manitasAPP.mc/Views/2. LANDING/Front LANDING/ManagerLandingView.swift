//
//  ManagerLandingView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 24/11/23.
//

import SwiftUI

struct ManagerLandingView: View {
    var body: some View {
        TabView {
            ManagerView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            DetalleOrdenManagerView()
                .tabItem {
                    Label("Orden", systemImage: "square.and.pencil")
                }
        }
    }
}

struct ManagerLandingView_Previews: PreviewProvider {
    static var previews: some View {
        ManagerLandingView()
    }
}
