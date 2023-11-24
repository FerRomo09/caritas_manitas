//
//  ManagerView.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 12/11/23.
//

import SwiftUI

struct ManagerView: View {
    @State var numOrdenes: Int = 0
    @State private var empleados: [Empleado] = []
    var body: some View {
        NavigationStack{
            VStack{
                
                NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)){
                    ProfileManagerView()
                }
                .padding(.bottom, 15)
                
                Text("Repartidores")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(Color("manitasNegro"))
                
                
                //Dashboard de repartidores
                ScrollView(.vertical, showsIndicators: true){
                    LazyVStack(){
    
                        Grid(horizontalSpacing: 12, verticalSpacing: 20) {
                            if numOrdenes % 2 == 0 { //Si es even el numero de repartidores
                                let x = numOrdenes / 2
                                ForEach(1...x, id: \.self) { i in
                                    GridRow(alignment: .top) {
                                        NavigationLink(destination: LandingManagerView().navigationBarBackButtonHidden(true)){
                                            ManagerOrderView()
                                        }
                                        NavigationLink(destination: LandingManagerView().navigationBarBackButtonHidden(true)){
                                            ManagerOrderView()
                                        }
                                    }
                                }
                            } else{ //si es odd el numero de repartidores
                                let x = (numOrdenes - 1) / 2
                                ForEach(1...x, id: \.self) { i in
                                    GridRow(alignment: .top) {
                                        NavigationLink(destination: LandingManagerView().navigationBarBackButtonHidden(true)){
                                            ManagerOrderView()
                                        }
                                        NavigationLink(destination: LandingManagerView().navigationBarBackButtonHidden(true)){
                                            ManagerOrderView()
                                        }
                                    }
                                }
                                GridRow(alignment: .top) {
                                    NavigationLink(destination: LandingManagerView().navigationBarBackButtonHidden(true)){
                                        ManagerOrderView()
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
