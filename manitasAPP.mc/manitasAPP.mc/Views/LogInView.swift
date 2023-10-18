//
//  LogInView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct LogInView: View {
    var body: some View {
        VStack{
            Text("Inicio de Sesión")
        
            ZStack(){
                Image("Cuadro")
                    .cornerRadius(24)
                
                HStack{
                    VStack(alignment: .leading){
                        HStack{Spacer()}
                        Text("Hola,")
                            .font(.system(size: 20))
                            .fontWeight(.regular)
                            .foregroundColor(Color("manitasNegro"))
                        Text("Maruca Cantu") //remplazar con nombre de variable
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                            .foregroundColor(Color("manitasNegro"))
                        HStack{Spacer()}
                    }
                    .padding(.leading, 40)
                    Image("Avatar")
                        .padding(.trailing, 30)
                    
                    
                }
            }
            
            Spacer()
            
        }.background(Color("manitasAzul"))
        
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
