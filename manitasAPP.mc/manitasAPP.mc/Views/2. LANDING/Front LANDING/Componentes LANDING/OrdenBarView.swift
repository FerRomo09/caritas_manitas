//
//  OrderBarView.swift
//  PRUEBA
//
//  Created by Jacobo Hirsch on 15/11/23.
//

import SwiftUI

struct OrdenBarView: View {
    // Para mostrar los detalles de la orden
    let orden: Orden
    @State private var listaOrdenes: [Orden] = []
    
    // Formateo de fecha
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    // Propiedades dinámicas basadas en el estatus de la orden
    private var textoRecibido: String {
        switch orden.estatusOrden {
        case 0:
            return "No recolectado"
        case 1:
            return "Pendiente"
        case 2:
            return "Recolectado"
        default:
            return "Desconocido"
        }
    }
    
    private var colorRecibido: Color {
        switch orden.estatusOrden {
        case 0:
            return .red
        case 1:
            return .green
        case 2:
            return .yellow
        default:
            return .gray
        }
    }
    
    private var iconRecibido: Image {
        switch orden.estatusOrden {
        case 0:
            return Image(systemName: "xmark.circle.fill")
        case 1:
            return Image(systemName: "checkmark.circle.fill")
        case 2:
            return Image(systemName: "exclamationmark.triangle.fill")
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
                    
                    Text("Recibo #\(orden.idOrden)")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                       
                        .padding(.bottom, 10)
                    Text("Donante: \(orden.nombre ?? "N/A") \(orden.apellidoPaterno) \(orden.apellidoMaterno ?? "")")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        
                    
                    // Colonia, municipio, codigo postal
                    Text("Col: \(orden.colonia)")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                       
                    Text("Mun: \(orden.municipio ?? "N/A")")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        
                    Text("CP: \(orden.codigoPostal)")
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

// Extensión para hacer esquinas redondeadas específicas
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

// Extensión para crear una instancia de ejemplo de 'Orden'
extension Orden {
    init(idOrden: Int64, fechaCobro: Date?, fechaPago: Date?, importe: Double?, estatusOrden: Int64?, comentarios: String?, comentariosReprogramacion: String?, nombre: String?, apellidoPaterno: String, apellidoMaterno: String?, callePrincipal: String, numeroExterior: Int64, colonia: String, codigoPostal: Int64, municipio: String?) {
        self.idOrden = idOrden
        self.fechaCobro = fechaCobro
        self.fechaPago = fechaPago
        self.importe = importe
        self.estatusOrden = estatusOrden
        self.comentarios = comentarios
        self.comentariosReprogramacion = comentariosReprogramacion
        self.nombre = nombre
        self.apellidoPaterno = apellidoPaterno
        self.apellidoMaterno = apellidoMaterno
        self.callePrincipal = callePrincipal
        self.numeroExterior = numeroExterior
        self.colonia = colonia
        self.codigoPostal = codigoPostal
        self.municipio = municipio
    }

    static var ejemplo: Orden {
        return Orden(
            idOrden: 12345,
            fechaCobro: Date(),
            fechaPago: Date(),
            importe: 1000.0,
            estatusOrden: 1,
            comentarios: "Comentario de ejemplo",
            comentariosReprogramacion: "Reprogramación de ejemplo",
            nombre: "Juan",
            apellidoPaterno: "Pérez",
            apellidoMaterno: "González",
            callePrincipal: "Avenida Siempre Viva",
            numeroExterior: 742,
            colonia: "Springfield",
            codigoPostal: 12345,
            municipio: "Ciudad Ejemplo"
        )
    }
}


// Código de la vista previa actualizado
struct OrdenBarView_Previews: PreviewProvider {
    static var previews: some View {
        OrdenBarView(orden: Orden.ejemplo)
    }
}


