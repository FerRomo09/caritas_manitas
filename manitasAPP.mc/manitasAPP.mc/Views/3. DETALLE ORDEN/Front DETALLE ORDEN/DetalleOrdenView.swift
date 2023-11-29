//
//  DetalleOrdenView.swift
//  AppManitas
//
//  Created by user223572 on 10/18/23.
//

import SwiftUI

struct DetalleOrdenView: View {
    let orden:Orden
   
    @Environment(\.presentationMode) var presentationMode
    @State private var ordenReprogramada = false
    
    //Para mostrar las opciones del boton rojo
    @State private var actionSheet = false
    @State private var offlineAlert = false
    
    @State var orderID = 2
    @State private var mostrarTexto = false
    @State private var razonUsuario = ""
    let address = "Av. Eugenio Garza Sada 2501 Sur, Tecnológico, 64849 Monterrey, Nuevo Leon"
    
    //@Environment(\.dismiss) var dismiss
    
    var body: some View {
            VStack{
                HStack {
                    Button("← Regresar") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
                //ProfileBarView()
                
                Spacer()
                ZStack{
                    
                    Image("Carusel")
                    
                    Text("Recibo #\(String(orden.idOrden))")//REEMPLAZAR POR VARIABLE
                        .font(.system(size: 25, weight: .bold))
                        .offset(x:-60, y:-200)
                    
                    
                    
                    Image("Top")
                        .offset(y:-130)
                    
                    
                    Text("Detalles del Recibo")
                        .offset(x:-60, y:-130)
                        .font(.system(size: 20, weight: .medium))
                    
                    Image("Bottom")
                        .offset(y:-60)
                    
                    HStack{
                        Text("Donante:")
                            .font(.system(size: 18))
                        Text("\(orden.nombre ?? "N/A") \(orden.apellidoPaterno) \(orden.apellidoMaterno ?? "")")
                            .font(.system(size: 18, weight: .light))
                    }
                    .offset(x:-15, y:-90)
                    
                    HStack{
                        Text("Cantidad:")
                            .font(.system(size: 18))
                        Text("\(String(orden.importeFormateado))")
                            .font(.system(size: 18, weight: .light))
                        
                    }.offset(x:-31, y:-62)
                    
                    HStack{
                        Text("Forma de pago:")
                            .font(.system(size: 18))
                        Text("Efectivo")
                            .font(.system(size: 18, weight: .light))
                        
                    }.offset(x:-40, y:-35)
                    
                    ZStack{
                        Image("Top2")
                            .offset(y:35)
                        Text("Dirección")
                            .font(.system(size: 20, weight: .medium))
                            .offset(x:-98, y:40)
                        
                        Image("Bottom2")
                            .offset(y:125)
                        
                        
                        HStack{
                            Text("Calle:")
                                .font(.system(size: 18))
                            Text("\(orden.callePrincipal)")
                                .font(.system(size: 18, weight: .light))
                        }
                        .offset(x:-38, y:78)
                        
                        HStack{
                            Text("Número Exterior:")
                                .font(.system(size: 18))
                            Text("123")//REEMPLAZAR POR VARIABLE
                                .font(.system(size: 18, weight: .light))
                        }
                        .offset(x:-52, y:101)
                        
                        HStack{
                            Text("Colonia:")
                                .font(.system(size: 18))
                            Text("\(orden.colonia)")
                                .font(.system(size: 18, weight: .light))
                        }
                        .offset(x:-64, y:123)
                        
                        HStack{
                            Text("Código Postal:")
                                .font(.system(size: 18))
                            Text("\(String(orden.codigoPostal))")
                                .font(.system(size: 18, weight: .light))
                        }
                        .offset(x:-48, y:145)
                        
                        HStack{
                            Text("Municipio:")
                                .font(.system(size: 18))
                            Text("\(orden.municipio ?? "N/A")")//REEMPLAZAR POR VARIABLE
                                .font(.system(size: 18, weight: .light))
                        }
                        .offset(x:-52, y:170)
                        
                        Button(action: {
                            openMapsForAddress(address: self.address)
                        }, label: {
                            Image("mapaBoton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                            
                        })
                        .offset(x:110, y:145)
                        
                    }
                }
                Spacer()
                
                if orden.estatusOrden != 1 && orden.estatusOrden != 2 {
                    Button("**Cobrado**"){
                        confirmOrder(orderID: Int(orden.idOrden)) { success, message in
                            if success {
                                print("Operación exitosa: \(message)")
                                DispatchQueue.main.async {
                                    self.presentationMode.wrappedValue.dismiss()
                                    
                                }
                            } else {
                                print("Error: \(message)")
                            }
                        }
                        
                        /*
                         checkConnection{connected in
                         if connected{
                         confirmOrder(orderID: orderID, token: token)
                         }
                         else{
                         offlineAlert = true
                         print("Error al confirmar orden")
                         }
                         }
                         */
                        
                    }
                    .controlSize(.large)
                    .frame(width: 1000)//checar
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .alert(isPresented: $offlineAlert){
                        Alert(title: Text("Error de conexión"), message: Text("No se pudo confirmar la orden"), dismissButton: .default(Text("OK")))
                    }
                    
                    Button("**No cobrado**"){
                        actionSheet = true
                    }
                    .actionSheet(isPresented: $actionSheet){
                        ActionSheet(title: Text("No se completo la orden"), message: Text("Elige la razon por la que no se pudo completar"), buttons: [
                            .default(Text("No se encontraba en casa")) { reprogramarConComentario("No se encontraba en casa") },
                            .default(Text("Ya no vive ahí")) { reprogramarConComentario("Ya no vive ahí") },
                            .default(Text("No desea continuar ayudando")) { reprogramarConComentario("No desea continuar ayudando") },
                            .default(Text("Indispuesto")) { reprogramarConComentario("Indispuesto") },
                            .default(Text("No se ubicó el domicilio")) {
                                reprogramarConComentario("No se ubicó el domicilio") },
                            .default(Text("Otra razón")){
                                mostrarTexto = true
                            },
                            .cancel()
                        ])
                    }
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    
                    if mostrarTexto{
                        ingresarRazon()
                        
                    }
                }
                
            }.padding()
    }
    
    func reprogramarConComentario(_ comentario: String) {
        let reprogramacionInfo = ReprogramacionInfo(comentarios: comentario)
        reprogramOrder(orderID: Int(orden.idOrden), reprogramacionInfo: reprogramacionInfo) { success, message in
            if success {
                print("Operación exitosa: \(message)")
                DispatchQueue.main.async {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } else {
                print("Error al reprogramar: \(message)")
            }
        }
    }
    
    func ingresarRazon() -> some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                    .padding(.leading)

                Text("Razón de no cobro")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            
            TextField("Escribe tu razón aquí", text: $razonUsuario)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .shadow(radius: 3)
                .padding(.horizontal)

            Button(action: {
                procesarRazonNoCobro()
            }) {
                HStack {
                    Image(systemName: "checkmark.circle.fill") // Icono para el botón
                        .foregroundColor(.white)
                    Text("Aceptar")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(10)
                .shadow(radius: 3)
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
        .transition(.slide)
    }
    
    func procesarRazonNoCobro() {
        let reprogramacionInfo = ReprogramacionInfo(comentarios: razonUsuario)
        
        reprogramOrder(orderID: Int(orden.idOrden), reprogramacionInfo: reprogramacionInfo) { success, message in
            if success {
                print("Operación exitosa: \(message)")
                DispatchQueue.main.async {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } else {
                print("Error al reprogramar: \(message)")
            }
        }
        mostrarTexto = false
        razonUsuario = ""
    }
    
    func openMapsForAddress(address: String) {
        let addressEncoded = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        if let url = URL(string: "http://maps.apple.com/?address=\(addressEncoded)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            print("Invalid address")
        }
    }
}



struct DetalleOrdenView_Previews: PreviewProvider {
    static var previews: some View {
        DetalleOrdenView(orden: Orden.ejemplo)
    }
}

