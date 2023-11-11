//
//  OrdenManagerBarView.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 10/11/23.
//

import SwiftUI

struct OrdenManagerBarView: View {
    @State var textoRecibido: String = "Recolectado"
    @State var colorRecibido: Color = .green
    @State var iconRecibido: Image = Image(systemName: "checkmark.circle.fill")

    var body: some View {
        ZStack(){
            Image("barGris")
                .resizable(resizingMode: .stretch)
                .cornerRadius(24)
                .frame(width:368, height: 100.0)
            
            HStack{
                VStack(alignment: .leading, spacing: 1.5){
                    HStack{Spacer()}
                    Text("Recibo #9182379") //remplazar con numero de orden
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color("manitasNegro"))
                        .padding(.bottom, 10)
                    Text("Donante: ")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("manitasNegro"))
                    + Text("Sr. Alberto Tamez V.")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .foregroundColor(Color("manitasNegro"))
                    
                    //Colinia, municipio, codigo postal
                    Text("Cantidad: ")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("manitasNegro"))
                    + Text("$1,800 pesos")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .foregroundColor(Color("manitasNegro"))
                    HStack{Spacer()}
                }
                .padding(.leading, 30)
                
                VStack(alignment: .trailing){
                    ZStack(){
                        Rectangle()
                            .frame(width: 104.0, height: 100.0)
                            .opacity(0.8)
                            .foregroundColor(colorRecibido)
                            .cornerRadius(0, corners: .topLeft)
                            .cornerRadius(24, corners: .topRight)
                            .cornerRadius(0, corners: .bottomLeft)
                            .cornerRadius(24, corners: .bottomRight)
                        
                        VStack(){
                            iconRecibido
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40, alignment: .center)
                                .padding(.bottom, 5)
                            
                            Text(textoRecibido)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                .padding(.trailing, 12)
            }
        }
    }
}


struct OrdenManagerBarView_Previews: PreviewProvider {
    static var previews: some View {
        // Directamente pasamos valores sin @State ya que no es necesario en previews.
        OrdenManagerBarView()
    }
}

