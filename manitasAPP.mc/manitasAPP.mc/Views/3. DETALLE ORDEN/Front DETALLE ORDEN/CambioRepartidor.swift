//
//  CambioRepartidor.swift
//  manitasAPP.mc
//
//  Created by Alumno on 12/11/23.
//

import SwiftUI


struct CambioRepartidor: View {
    @Environment(\.presentationMode) var presentationMode
    var orderID = 1
    @State var empID = 1
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

               Picker("Selecciona un repartidor", selection: $empID){
                   ForEach(0..<repartidores.count) {
                       Text(repartidores[$0].nombre).tag(repartidores[$0].id)
                   }
               }
               .pickerStyle(.inline)
               
               

               Button("**Confirmar Reasignación**                   ") {
                   changeEmployeeOrder(orderID: orderID, empID: empID)
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
