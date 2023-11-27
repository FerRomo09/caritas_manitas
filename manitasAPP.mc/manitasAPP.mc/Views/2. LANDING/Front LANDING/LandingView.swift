//
//  LandingView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI
import Foundation

struct LandingView: View {
    @State private var listaOrdenes: [Orden] = []
    @State private var ordenesPendientes: [Orden] = []
    @State private var ordenesRecolectadas: [Orden] = []
    @State private var ordenesNoRecolectadas: [Orden] = []

    var body: some View {
        
        NavigationStack(){
            VStack(){
                VStack(){
                    NavigationLink(destination: (ProfileView())){
                        ProfileBarView()
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                    .navigationBarBackButtonHidden(false)
                }
                
                //Stack ordenes del dia
                VStack(alignment: .leading){
                    
                    HStack{Spacer()}
                    Text("Recibos del Día: ")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color("manitasNegro"))
                    + Text("15")//REEMPLAZAR POR VARIABLES
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color("manitasAzul"))
                }
                .padding(.horizontal, 40)
                ProgressView(value: 20, total: 100)
                    .padding(.horizontal, 40) //Remplazar
                    .tint(Color("manitasAzul"))
                Text("Recibos faltantes: ")
                    .font(.system(size: 15))
                    .foregroundColor(Color("manitasNegro"))
                + Text("20") //REEMPLAZAR POR VARIABLE ENTERA
                    .font(.system(size: 15))
                    .foregroundColor(Color("manitasAzul"))
            }
            .padding(.bottom, 10)
            
            List {
                Section(header: Text("Pendientes")) {
                    ForEach(ordenesPendientes, id: \.idOrden) { orden in
                        NavigationLink(destination: DetalleOrdenView(orden: orden)) {
                            OrdenBarView(orden: orden)
                        }
                    }
                }

                Section(header: Text("Recolectadas")) {
                    ForEach(ordenesRecolectadas, id: \.idOrden) { orden in
                        NavigationLink(destination: DetalleOrdenView(orden: orden)) {
                            OrdenBarView(orden: orden)
                        }
                    }
                }

                Section(header: Text("No Recolectadas")) {
                    ForEach(ordenesNoRecolectadas, id: \.idOrden) { orden in
                        NavigationLink(destination: DetalleOrdenView(orden: orden)) {
                            OrdenBarView(orden: orden)
                        }
                    }
                }
            }
            .onAppear {
                fetchOrders(forEmployeeID: 1, forEstatusId: 0) { ordenes in
                    self.ordenesPendientes = ordenes
                }
                fetchOrders(forEmployeeID: 1, forEstatusId: 1) { ordenes in
                    self.ordenesRecolectadas = ordenes
                }
                fetchOrders(forEmployeeID: 1, forEstatusId: 2) { ordenes in
                    self.ordenesNoRecolectadas = ordenes
                }
            }

            //Manda foto para arriba
            Spacer()
        }
    }
}


struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
