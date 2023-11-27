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
    @State var orderID = 1
    @State private var mostrarTexto = false
    @State private var razonUsuario = ""
    let address = "Av. Eugenio Garza Sada 2501 Sur, Tecnológico, 64849 Monterrey, Nuevo Leon"
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            /*
            
            HStack {
                Button("← Regresar") {
                    dismiss()
                }
                Spacer()
            }
            */
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
                    Text("Direccion")
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
                        Text("Numero Exterior:")
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
                        Text("Codigo Postal:")
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
                        Image("Reemplazar")
                            
                    })
                    .offset(x:110, y:145)
                    
                    
                }
    
            }
            Spacer()
            Button("Cobrado"){
                let reprogramacionInfo = ReprogramacionInfo(comentarios: "Reprogramación a estatus Cobrado")
                  reprogramOrder(orderID: Int(orden.idOrden), reprogramacionInfo: reprogramacionInfo) { success, message in
                      if success {
                          ordenReprogramada = true
                          // Regresar a la lista de órdenes
                          DispatchQueue.main.async {
                              self.presentationMode.wrappedValue.dismiss()
                          }
                      } else {
                          print(message)
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
            .frame(width: 1000)//checar
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .alert(isPresented: $offlineAlert){
                Alert(title: Text("Error de conexión"), message: Text("No se pudo confirmar la orden"), dismissButton: .default(Text("OK")))
            }
        
            
            Button("No cobrado"){
                actionSheet = true
                
            }
            .actionSheet(isPresented: $actionSheet){
                ActionSheet(title: Text("No se completo la orden"), message: Text("Elige la razon por la que no se pudo completar"), buttons: [
                    
                    .default(Text("No se encontraba en casa")),
                    .default(Text("Ya no vive ahi")),
                    .default(Text("No desea continuar ayudando")),
                    .default(Text("Indispuesto")),
                    .default(Text("No se ubicó el domicilio")),
                    .default(Text("Otra razon")){
                        mostrarTexto = true
                    },
                    .cancel()
                ])
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            
            if mostrarTexto{
                ingresarRazon()
                
            }
            
            
        }.padding()
    }
    //Funcion para que el usuario ingrese el texto y se hace un print
    func ingresarRazon() -> some View{
        
        VStack {
            TextField("Escribe tu razón aquí", text: $razonUsuario)
                //.textFieldStyle(RoundedBorderTextFieldStyle())
                .textFieldStyle(.roundedBorder)
                
            
            Button("Aceptar") {
                // Procesa la razón escrita por el usuario
                print(razonUsuario)
                mostrarTexto = false
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    
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

