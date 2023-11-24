//
//  ManagerView.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 12/11/23.
//

import SwiftUI

struct ManagerView: View {
    
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
                    HStack{
                        NavigationLink(destination: LandingManagerView().navigationBarBackButtonHidden(true)){
                            ManagerOrderView()
                        }
                        
                        
                        NavigationLink(destination: LandingManagerView().navigationBarBackButtonHidden(true)){
                            ManagerOrderView()
                                .navigationBarBackButtonHidden(true)
                        }
                    }
                    
                    
                    HStack{
                        NavigationLink(destination: LandingManagerView().navigationBarBackButtonHidden(true)){
                            ManagerOrderView()
                        }
                        NavigationLink(destination: LandingManagerView().navigationBarBackButtonHidden(true)){
                            ManagerOrderView()
                        }
                    }
                    HStack{
                        NavigationLink(destination: LandingManagerView().navigationBarBackButtonHidden(true)){
                            ManagerOrderView()
                        }
                        NavigationLink(destination: LandingManagerView().navigationBarBackButtonHidden(true)){
                            ManagerOrderView()
                        }
                    }
                   
                }

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
