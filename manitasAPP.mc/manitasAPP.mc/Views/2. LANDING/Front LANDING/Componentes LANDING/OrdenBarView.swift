//
//  OrderBarView.swift
//  PRUEBA
//
//  Created by Jacobo Hirsch on 15/11/23.
//

import SwiftUI

struct OrdenBarView: View {
    //Variable de tipo orden
    let orden: Orden
    
    // Propiedades dinámicas basadas en el estatus de la orden
    private var textoRecibido: String {
        switch orden.estatusOrden {
        case 0:
            return "Pendiente"
        case 1:
            return "Recolectado"
        case 2:
            return "No Recolectado"
        default:
            return "Desconocido"
        }
    }
    
    private var colorRecibido: Color {
        switch orden.estatusOrden {
        case 0:
            return .yellow
        case 1:
            return .green
        case 2:
            return .red
        default:
            return .gray
        }
    }
    
    private var iconRecibido: Image {
        switch orden.estatusOrden {
        case 0:
            return Image(systemName: "exclamationmark.triangle.fill")
        case 1:
            return Image(systemName: "checkmark.circle.fill")
        case 2:
            return Image(systemName: "xmark.circle.fill")
        default:
            return Image(systemName: "questionmark.circle.fill")
        }
    }

    var body: some View {
        ZStack {
            Image("barGris")
                .resizable(resizingMode: .stretch)
                .cornerRadius(24)
                .frame(width: 368, height: 150.0)
            
            
            
            HStack {
                
                VStack(alignment: .leading, spacing: 1.5) {
                    
                    HStack { Spacer() }
                    
                    Text("Recibo #\(String(orden.idOrden))")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                       
                        .padding(.bottom, 10)
                    Text("Donante: \(orden.nombre ?? "N/A") \(orden.apellidoPaterno) \(orden.apellidoMaterno ?? "")")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        
                    
                    // Colonia, municipio, código postal
                    Text("Col: \(orden.colonia)")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                       
                    Text("Mun: \(orden.municipio ?? "N/A")")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        
                    Text("C.P.: \(String(orden.codigoPostal))")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        
                    
                    HStack { Spacer() }
                
                    
                }
                .padding(.leading, 30)
                
                
                VStack(alignment: .trailing) {
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 104.0, height: 150.0)
                            .opacity(0.8)
                            .foregroundColor(colorRecibido)
                            .cornerRadius(24, corners: [.topRight, .bottomRight])
                        
                        VStack {
                            iconRecibido
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40, alignment: .center)
                                .padding(.bottom, 5)
                            
                            Text(textoRecibido)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .font(.system(size: 13))
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                .padding(.trailing, 12)
            }
        }
    }
}

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
        OrdenBarView(orden: Orden.ejemplo)
    }
}

