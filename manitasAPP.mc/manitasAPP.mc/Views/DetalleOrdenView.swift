//
//  DetalleOrdenView.swift
//  AppManitas
//
//  Created by user223572 on 10/18/23.
//

import SwiftUI

struct DetalleOrdenView: View {
    //Para mostrar las opciones del boton rojo
    @State private var actionSheet = false
    //Booleano para
    @State private var mostrarTexto = false
    @State private var razonUsuario = " "
    
    var body: some View {
        VStack{
            ProfileBarView()
            
            Spacer()
            ZStack{

                Image("Carusel")
            
                Text("Recibo #5148132")//REEMPLAZAR POR VARIABLE
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
                    Text("Sr. Francisco Torres J.")//REEMPLAZAR POR VARIABLE
                        .font(.system(size: 18, weight: .ultraLight))
                }
                .offset(x:-15, y:-90)
            
                HStack{
                    Text("Cantidad:")
                        .font(.system(size: 18))
                    Text("$2,500.00 pesos")//REEMPLAZAR POR VARIABLE
                        .font(.system(size: 18, weight: .ultraLight))
                        
                }.offset(x:-31, y:-62)
                
                HStack{
                    Text("Forma de pago:")
                        .font(.system(size: 18))
                    Text("Efectivo")//REEMPLAZAR POR VARIABLE
                        .font(.system(size: 18, weight: .ultraLight))
                        
                }.offset(x:-40, y:-35)
                
                ZStack{
                    Image("Top2")
                        .offset(y:35)
                    Text("Direccion")//REEMPLAZAR POR VARIABLE
                        .font(.system(size: 20, weight: .medium))
                        .offset(x:-98, y:40)
                    
                    Image("Bottom2")
                        .offset(y:125)
                    
                    
                    HStack{
                        Text("Calle:")
                            .font(.system(size: 18))
                        Text("Avenida Revolucion")//REEMPLAZAR POR VARIABLE
                            .font(.system(size: 18, weight: .ultraLight))
                    }
                    .offset(x:-38, y:78)
                    
                    HStack{
                        Text("Numero Exterior:")
                            .font(.system(size: 18))
                        Text("123")//REEMPLAZAR POR VARIABLE
                            .font(.system(size: 18, weight: .ultraLight))
                    }
                    .offset(x:-52, y:101)
                    
                    HStack{
                        Text("Colonia:")
                            .font(.system(size: 18))
                        Text("Los Pinos")//REEMPLAZAR POR VARIABLE
                            .font(.system(size: 18, weight: .ultraLight))
                    }
                    .offset(x:-64, y:123)
                    
                    HStack{
                        Text("Codigo Postal:")
                            .font(.system(size: 18))
                        Text("64840")//REEMPLAZAR POR VARIABLE
                            .font(.system(size: 18, weight: .ultraLight))
                    }
                    .offset(x:-48, y:145)
                    
                    HStack{
                        Text("Municipio:")
                            .font(.system(size: 18))
                        Text("Monterrey")//REEMPLAZAR POR VARIABLE
                            .font(.system(size: 18, weight: .ultraLight))
                    }
                    .offset(x:-52, y:170)
                    
                    Image("Reemplazar")
                        .offset(x:110, y:145)
                    
                    
                }
    
            }
            Spacer()
            Button("Cobrado"){
                
            }
            .frame(width: 1000)//checar

            .buttonStyle(.borderedProminent)
            .tint(.green)
        
            
            Button("No cobrado"){
                actionSheet = true
                
            }
            .actionSheet(isPresented: $actionSheet){
                ActionSheet(title: Text("No se completo la orden"), message: Text("Elige la razon por la que no se pudo completar"), buttons: [
                    
                    .default(Text("El donante no se encontraba en su domicilio")),
                    .default(Text("El donante no disponía de la cantidad exacta")),
                    .default(Text("El donante no tenía efectivo")),
                    .default(Text("El donante reprogamo la fecha")),
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
}



struct DetalleOrdenView_Previews: PreviewProvider {
    static var previews: some View {
        DetalleOrdenView()
    }
}
