//
//  ManagerOrderView.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 12/11/23.
//

import SwiftUI

struct ManagerOrderView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Image("rec1")
                Image("rec2")
                    .offset(y:80)
                Image("icono")
                    .offset(x:50, y:30)

                VStack(alignment:.leading){
                    Text("Gerardo R.") //REEMPLAZAR
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color("manitasNegro"))
                    Text("Obregon") //REEMPLAZAR
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color("manitasNegro"))
                    Text("15 ordenes") //REEMPLAZAR
                        .padding(.top,2)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("manitasNegro"))
    
                }
                .padding(.leading)
                .offset(x: -30, y:-30)
                
                Text("Ver detalles")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .offset(y:80)
            }
        }

    }
}

struct ManagerOrderView_Previews: PreviewProvider {
    static var previews: some View {
        ManagerOrderView()
    }
}
