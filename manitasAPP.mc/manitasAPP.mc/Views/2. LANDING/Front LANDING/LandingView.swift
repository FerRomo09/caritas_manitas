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
    @State private var isView1Active = true
    @State private var toggleText = ""
    @State private var toggleIcon = "star"

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
                NavigationView{
                    VStack{
                        VStack{
                            if isView1Active {
                                View1()
                               //toggleIcon = "arrow.right.circle.fill"
                            } else {
                                View2()
                                //toggleIcon = "arrow.backward.circle.fill"

                            }
                        }
                        Spacer()
                        HStack{
                            HStack{Spacer()}
                            Button(action: {
                                // Toggle between views
                                isView1Active.toggle()
                            }) {
                                Image(systemName: toggleIcon)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color("manitasAzul"))
                            }
                            HStack{Spacer()}
                        }
                    }
                }
                .frame(height:150)
                
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
            } //Vstack
        } //navstck
    }//var body
}

struct View1: View {
    var body: some View {
        ProgressBarView()
    }
}
struct View2: View {
    var body: some View {
        DineroProgressBarView()
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
