//
//  ordenBarView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct OrdenBarView: View {    
    var body: some View {
        ZStack(){
            Image("barGris")
                .cornerRadius(24)
            
            HStack{
                VStack(alignment: .leading){
                    HStack{Spacer()}
                    Text("Recibo #9182379") //remplazar con numero de orden
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
                
                VStack(alignment: .trailing){
                    ZStack(){
                        Rectangle()
                            .frame(width: 84.0, height: 91.0)
                            .opacity(0.8)
                            .foregroundColor(.green)
                            .cornerRadius(0, corners: .topLeft)
                            .cornerRadius(24, corners: .topRight)
                            .cornerRadius(0, corners: .bottomLeft)
                            .cornerRadius(24, corners: .bottomRight)
                        
                        VStack(){
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.white)
                                .frame(width: 28, height: 28, alignment: .center)
                            
                            Text("Completado")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .font(.system(size: 10))
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
        OrdenBarView()
    }
}
