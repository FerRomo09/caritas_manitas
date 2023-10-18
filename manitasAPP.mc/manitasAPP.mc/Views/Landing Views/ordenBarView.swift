//
//  ordenBarView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct ordenBarView: View {
    var body: some View {
        ZStack(){
            Image("barGris")
                .cornerRadius(24)
            
            HStack{
                VStack(alignment: .leading){
                    HStack{Spacer()}
                
                    Text("Orden #9182379") //remplazar con numero de orden
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color("manitasNegro"))
                    Text("Donante: ")
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(Color("manitasNegro"))
                    + Text("Sr. Alberto Tamez V.")
                        .font(.system(size: 18))
                        .fontWeight(.thin)
                        .foregroundColor(Color("manitasNegro"))
                    Text("Cantidad: ")
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(Color("manitasNegro"))
                    + Text("$1,500 pesos")
                        .font(.system(size: 18))
                        .fontWeight(.thin)
                        .foregroundColor(Color("manitasNegro"))
                    
                    HStack{Spacer()}
                }
                .padding(.leading, 30)
            
            }
        }
    }
}

struct ordenBarView_Previews: PreviewProvider {
    static var previews: some View {
        ordenBarView()
    }
}
