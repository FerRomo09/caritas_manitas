//
//  profileBarView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct profileBarView: View {
    var body: some View {
        ZStack(){
            Image("bar")
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
    }
}

struct profileBarView_Previews: PreviewProvider {
    static var previews: some View {
        profileBarView()
    }
}
