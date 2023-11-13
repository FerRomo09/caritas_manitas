//
//  LandingView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI
import Foundation

struct LandingView: View {
    @State var nombreRecibido: String=""
    @State var tokenRecibido: String=""
    @State private var textoStatus: String = "Recolectado"
    @State private var colorStatus: Color = .green
    @State private var iconStatus: Image = Image(systemName: "checkmark.circle.fill")
    @State private var numStatus: Int = 3
    @State private var numRecibos: Int = 15
    @State private var arrayNumStatus: [Int] = [1,2,3]

    
    var body: some View {
        
        NavigationStack(){
            //Main VStack
            VStack(){
                
                
                //Profile Bar, link a profile view
                VStack(){
                    NavigationLink(destination: (ProfileView(token: tokenRecibido))){
                        ProfileBarView(nombreRecibidoPB: nombreRecibido)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                    .navigationBarBackButtonHidden(true)
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
            
            ScrollView(.vertical, showsIndicators: true){
                
                LazyVStack(){
                    //Itera n veces
                        
                    ForEach(1...15, id: \.self) {
                        i in
                        let numStatus = Int.random(in: 1..<4)
                        if (numStatus == 3){
                            let textoStatus = "Recolectado"
                            let colorStatus = Color.green
                            let iconStatus = Image(systemName: "checkmark.circle.fill")
                            NavigationLink(destination: (DetalleOrdenView(token: tokenRecibido))){
                                OrdenBarView(textoRecibido: textoStatus, colorRecibido: colorStatus, iconRecibido: iconStatus)
                            }
                        } else if (numStatus == 2){
                            let textoStatus = "Pendiente"
                            let colorStatus = Color.yellow
                            let iconStatus = Image(systemName: "exclamationmark.triangle.fill")
                            NavigationLink(destination: (DetalleOrdenView())){
                                OrdenBarView(textoRecibido: textoStatus, colorRecibido: colorStatus, iconRecibido: iconStatus)
                            }
                        }else if (numStatus == 1){
                            let textoStatus = """
                            No
                            recolectado
                            """
                            let colorStatus = Color.red
                            let iconStatus = Image(systemName: "xmark.circle.fill")
                            NavigationLink(destination: (DetalleOrdenView())){
                                OrdenBarView(textoRecibido: textoStatus, colorRecibido: colorStatus, iconRecibido: iconStatus)
                            }
                        }
                         }
                         
                    
                    //OrdenBarView(textoRecibido: textoStatus, colorRecibido: colorStatus, iconRecibido: iconStatus)
                }
            }
            
            //Manda foto para arriba
            Spacer()
        }
        /*Array numberos del 1 -3
         //var arrayNumStatus: [Int] = [0]
         ForEach (1...numRecibos, id: \.self){
         i in
         let numRandom = Int.random(in: 1..<4)
         arrayNumStatus.append(numRandom)
         }
         */
        
        
    }
}


struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
