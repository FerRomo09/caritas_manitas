//
//  ManagerView.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 12/11/23.
//

import SwiftUI

struct ManagerView: View {
    @State var numOrdenes: Int = 3
    @State private var empleados: Empleado = []
    var body: some View {
        NavigationStack{
            VStack{
                
                NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)){
                    ProfileManagerView()
                }
                Text("Ordenes Asignadas")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
                Divider()
                Text("Repartidores Activos")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color("manitasNegro"))
                
                ScrollView(.vertical, showsIndicators: true){
                    LazyVStack() {
                        Grid(horizontalSpacing: 12, verticalSpacing: 20) {
                            ForEach(0..<(empleados.count / 2 + empleados.count % 2), id: \.self) { i in
                                let firstIndex = i * 2
                                let secondIndex = min((i * 2) + 1, self.empleados.count - 1)
                                GridRow(alignment: .top) {
                                    NavigationLink(destination: LandingManagerView().navigationBarBackButtonHidden(true)) {
                                        ManagerOrderView(nombre: self.empleados[firstIndex].nombre, numeroOrdenes: self.empleados[firstIndex].num_ordenes)
                                    }
                                    NavigationLink(destination: LandingManagerView().navigationBarBackButtonHidden(true)) {
                                        ManagerOrderView(nombre: self.empleados[secondIndex].nombre, numeroOrdenes: self.empleados[secondIndex].num_ordenes)
                                    }
                                }
                            }
                        }
                    }
                    
                } //se acaba el scroll view
                
                Spacer()
                
            }
            
            .onAppear {
                // Call the function when the view appears
                getEmpleados() { result in
                    switch result {
                    case .success(let empleados):
                        self.empleados = empleados
                        self.numOrdenes = empleados.count
                    case .failure(let error):
                        print("Error fetching empleados: \(error)")
                    }
                }
            }
            
        }
    }
}

struct ManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ManagerView()
    }
}
