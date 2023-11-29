//
//  DetalleOrdenManagerView.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 10/11/23.
//

import SwiftUI
struct DetalleOrdenManagerView: View {
    var idRepartridor:Int
    let orden:Orden
    @Environment(\.presentationMode) var presentationMode
    @State private var isActive = false
    let address = "Av. Eugenio Garza Sada 2501 Sur, Tecnológico, 64849 Monterrey, Nuevo Leon"

    var body: some View {
        VStack{
            HStack {
                Button("← Regresar") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }.padding(.horizontal, 20)
            NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)){
                ProfileManagerView()
            }

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

                VStack(){
                    
                    VStack(alignment: .leading){
                        HStack(alignment: .top){
                            Text("Donante:")
                                .font(.system(size: 18))
                            Text("\(orden.nombre ?? "N/A") \(orden.apellidoPaterno) \(orden.apellidoMaterno ?? "")")
                                .font(.system(size: 18, weight: .light))
                        }
                        HStack{
                            Text("Cantidad:")
                                .font(.system(size: 18))
                            Text("\(String(orden.importeFormateado))")
                                .font(.system(size: 18, weight: .light))
                        }
                        HStack{
                            Text("Forma de pago:")
                                .font(.system(size: 18))
                            Text("Efectivo")
                                .font(.system(size: 18, weight: .light))
                        }
                    }
                    .offset(x:-30,y:30)
                  

                    ZStack{
                       
                        Image("Top2")
                        Image("Bottom2")
                            .offset(y:90)
                        
                        Text("Dirección")
                            .font(.system(size: 20, weight: .medium))
                            .offset(x:-100)
         
                        VStack(alignment: .leading){
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Calle:")
                                        .font(.system(size: 18))
                                    Text("\(orden.callePrincipal)")
                                        .font(.system(size: 18, weight: .light))
                                }

                                HStack{
                                    Text("Número Exterior:")
                                        .font(.system(size: 18))
                                    Text("123")//REEMPLAZAR POR VARIABLE
                                        .font(.system(size: 18, weight: .light))
                                }

                                HStack{
                                    Text("Colonia:")
                                        .font(.system(size: 18))
                                    Text("\(orden.colonia)")
                                        .font(.system(size: 18, weight: .light))
                                }
      
                                HStack{
                                    Text("Código Postal:")
                                        .font(.system(size: 18))
                                    Text("\(String(orden.codigoPostal))")
                                        .font(.system(size: 18, weight: .light))
                                }
             
                                HStack{
                                    Text("Municipio:")
                                        .font(.system(size: 18))
                                    Text("\(orden.municipio ?? "N/A")")//REEMPLAZAR POR VARIABLE
                                        .font(.system(size: 18, weight: .light))
                                }
                            }
                            .offset(x:-30,y:130)
     
                            Button(action: {
                                openMapsForAddress(address: self.address)
                            }, label: {
                                Image("mapaBoton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60)
                            })
                            .offset(x:180, y:25)
                        }
                    }
                }
            }

            NavigationView{
                VStack{
                    NavigationLink(destination: CambioRepartidor(orderID: Int(orden.idOrden), empID: idRepartridor)) {
                        Text("Reasignar Repartidor")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct DetalleOrdenManagerView_Previews: PreviewProvider {
    static var previews: some View {
        DetalleOrdenManagerView(idRepartridor: 2, orden: Orden.ejemplo)
    }
}
