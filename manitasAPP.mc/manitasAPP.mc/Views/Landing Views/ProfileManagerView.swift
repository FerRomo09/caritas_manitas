//
//  ProfileManagerView.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 10/11/23.
//

import SwiftUI

struct ProfileManagerView: View {
    @State var nombreRecibidoPB: String = "Manager"
    var body: some View {
        ZStack(){
            Image("barManager")
                .cornerRadius(24)
            
            HStack{
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    Text("Hola,")
                        .font(.system(size: 20))
                        .fontWeight(.regular)
                        .foregroundColor(Color("manitasNegro"))
                    Text(nombreRecibidoPB) //remplazar con nombre de variable
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

struct ProfileManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileManagerView()
    }
}
