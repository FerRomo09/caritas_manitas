//
//  DetalleOrdenManagerView.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 10/11/23.
//

import SwiftUI

struct DetalleOrdenManagerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isActive = false
    
    var body: some View {
        VStack{
            HStack {
                Button("← Regresar") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }.padding(.horizontal, 20)
            ProfileManagerView()
            
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
                        .font(.system(size: 18, weight: .light))
                }
                .offset(x:-15, y:-90)
                
                HStack{
                    Text("Cantidad:")
                        .font(.system(size: 18))
                    Text("$2,500.00 pesos")//REEMPLAZAR POR VARIABLE
                        .font(.system(size: 18, weight: .light))
                    
                }.offset(x:-31, y:-62)
                
                HStack{
                    Text("Teléfono:")
                        .font(.system(size: 18))
                    Text("3221231231")//REEMPLAZAR POR VARIABLE
                        .font(.system(size: 18, weight: .light))
                    
                }.offset(x:-40, y:-35)
                
                ZStack{
                    Image("Top2")
                        .offset(y:35)
                    Text("Dirección")//REEMPLAZAR POR VARIABLE
                        .font(.system(size: 20, weight: .medium))
                        .offset(x:-98, y:40)
                    
                    Image("Bottom2")
                        .offset(y:125)
                    
                    
                    HStack{
                        Text("Calle:")
                            .font(.system(size: 18))
                        Text("Avenida Revolucion")//REEMPLAZAR POR VARIABLE
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
                        Text("Los Pinos")//REEMPLAZAR POR VARIABLE
                            .font(.system(size: 18, weight: .light))
                    }
                    .offset(x:-64, y:123)
                    
                    HStack{
                        Text("Código Postal:")
                            .font(.system(size: 18))
                        Text("64840")//REEMPLAZAR POR VARIABLE
                            .font(.system(size: 18, weight: .light))
                    }
                    .offset(x:-48, y:145)
                    
                    HStack{
                        Text("Municipio:")
                            .font(.system(size: 18))
                        Text("Monterrey")//REEMPLAZAR POR VARIABLE
                            .font(.system(size: 18, weight: .light))
                    }
                    .offset(x:-52, y:170)
                    
                    Image("Reemplazar")
                        .offset(x:110, y:145)
                    
                }
               
            }
            Spacer()
            
            
            NavigationView{
                VStack{
                    NavigationLink(destination: CambioRepartidor()) {
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
        DetalleOrdenManagerView()
    }
}
