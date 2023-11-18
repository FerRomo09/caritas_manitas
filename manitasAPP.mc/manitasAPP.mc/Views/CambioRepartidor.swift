//
//  CambioRepartidor.swift
//  manitasAPP.mc
//
//  Created by Alumno on 12/11/23.
//

import SwiftUI


struct CambioRepartidor: View {
    @Environment(\.presentationMode) var presentationMode
    let orderID = "#5148132"
    let deliveryPeople = ["Hernan Ramirez", "Enrique Torres", "Guillermo Alarcon", "Pablo Zubiria", "Gaston Belden"]
    @State private var repartidorSelect = "Hernan Ramirez"
    @State private var isActive = false
    
    var body: some View {
        
           VStack {
               HStack {
                   //Spacer()
                   Button("Regresar") {
                       // A donde regresa
                   }
                   Spacer()
                   .padding()
               }
               Text("Reasignar Repartidor")
                   .font(.title)
                   .padding()

               Text("Escoge nuevo repartidor para:")
               Text("Orden \(orderID)")
                   .bold()
                   .padding(.bottom)

               Picker("Selecciona un repartidor", selection: $repartidorSelect){
                   ForEach(deliveryPeople, id: \.self) {
                       Text($0)
                   }
               }
               .pickerStyle(.inline)
               
               

               Button("Confirmar reasignacion") {
                               presentationMode.wrappedValue.dismiss()
                           }
                           .padding()
                           .background(Color.green)
                           .foregroundColor(.white)
                           .cornerRadius(10)
               Spacer()
           }
           .padding(.all, 20)
       }
   }


struct CambioRepartidor_Previews: PreviewProvider {
    static var previews: some View {
        CambioRepartidor()
    }
}
