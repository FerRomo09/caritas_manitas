//
//  ManagerView.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 12/11/23.
//

import SwiftUI

struct ManagerView: View {
    @State var numOrdenes: Int = 9
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
                        //Eventualmente poner ids en los repartidores
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
        }
    }
}

struct ManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ManagerView()
    }
}
