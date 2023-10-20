//
//  ordenBarView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct OrdenBarView: View {
    @State var textoRecibido: String = "Completado"
    @State var colorRecibido: Color = .green
    @State var iconRecibido: Image = Image(systemName: "checkmark.circle.fill")

    var body: some View {
        ZStack(){
            Image("barGris")
                .resizable(resizingMode: .stretch)
                .cornerRadius(24)
                .frame(width:368, height: 150.0)
            
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
                        .fontWeight(.thin)
                        .foregroundColor(Color("manitasNegro"))
                    
                    //Colinia, municipio, codigo postal
                    Text("Col: ")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("manitasNegro"))
                    + Text("Prolongacion Chipinque")
                        .font(.system(size: 16))
                        .fontWeight(.thin)
                        .foregroundColor(Color("manitasNegro"))
                    Text("Mun: ")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("manitasNegro"))
                    + Text("Santa Catarina")
                        .font(.system(size: 16))
                        .fontWeight(.thin)
                        .foregroundColor(Color("manitasNegro"))
                    Text("CP: ")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("manitasNegro"))
                    + Text("66290")
                        .font(.system(size: 16))
                        .fontWeight(.thin)
                        .foregroundColor(Color("manitasNegro"))
                    
                    HStack{Spacer()}
                }
                .padding(.leading, 30)
                
                VStack(alignment: .trailing){
                    ZStack(){
                        Rectangle()
                            .frame(width: 104.0, height: 150.0)
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
                            
                            Text(textoRecibido)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14))
                        }
                    }
                }
                .padding(.trailing, 12)
            }
        }
    }
}

//Estructura para hacer rounded corners specificos
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct OrdenBarView_Previews: PreviewProvider {
    static var previews: some View {
        @State var variableTempTexto: String = "Completado"
        @State var variableTempColor: Color = .green
        @State var variableTempIcon: Image = Image(systemName: "checkmark.circle.fill")
        OrdenBarView(textoRecibido: variableTempTexto, colorRecibido: variableTempColor, iconRecibido: variableTempIcon)
    }
}
