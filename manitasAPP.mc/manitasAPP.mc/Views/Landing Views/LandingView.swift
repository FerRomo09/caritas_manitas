//
//  LandingView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationStack(){
            //Main VStack
            VStack(){
                
                //Profile Bar, link a profile view
                VStack(){
                    NavigationLink(destination: (profileView())){
                        profileBarView()
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 15)
                }
                
                //Stack ordenes del dia
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    Text("Ordenes del dia: ")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color("manitasNegro"))
                    + Text("15")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color("manitasAzul"))
                }
                .padding(.horizontal, 40)
                ProgressView(value: 20, total: 100)
                    .padding(.horizontal, 40) //Remplazar
                    .tint(Color("manitasAzul"))
                Text("Ordenes Completadas: ")
                    .font(.system(size: 15))
                    .foregroundColor(Color("manitasNegro"))
                + Text("20%") //Remplazar con variables
                    .font(.system(size: 15))
                    .foregroundColor(Color("manitasAzul"))
                
                //Manda foto para arriba
                Spacer()
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
