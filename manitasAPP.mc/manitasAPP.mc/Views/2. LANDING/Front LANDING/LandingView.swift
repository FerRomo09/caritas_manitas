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
    
    @State private var textoStatus: String = "Recolectado"
    @State private var colorStatus: Color = .green
    @State private var iconStatus: Image = Image(systemName: "checkmark.circle.fill")
    @State private var numStatus: Int = 3


    var body: some View {
        
        NavigationStack(){
            //Main VStack
            VStack(){
                
                
                //Profile Bar, link a profile view
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
                    Text("Recibos del dia: ")
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
            
            List(listaOrdenes, id: \.idOrden) { orden in
                OrdenBarView(orden: orden)
            }
            .onAppear {
                fetchOrders(forEmployeeID: 1, forEstatusId: 2) { ordenes in
                    self.listaOrdenes = ordenes
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
