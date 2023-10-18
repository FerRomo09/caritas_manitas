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
                    .padding(.bottom, 20)
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
        
                    ProgressView(value: 20, total: 100) //Remplazar
                        .tint(Color("manitasAzul"))
                    Text("Ordenes Completadas: 13.33% (3)") //Remplazar con variables
                        
                }
                .padding(.horizontal, 40)
                
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
