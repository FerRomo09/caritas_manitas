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
                ProfileManagerView()
                Text("Ordenes asignadas")
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
                        NavigationLink(destination: LandingManagerView()){
                            ManagerOrderView()
                        }
                        NavigationLink(destination: LandingManagerView()){
                            ManagerOrderView()
                        }
                    }
                    
                    HStack{
                        NavigationLink(destination: LandingManagerView()){
                            ManagerOrderView()
                        }
                        NavigationLink(destination: LandingManagerView()){
                            ManagerOrderView()
                        }
                    }
                    HStack{
                        NavigationLink(destination: LandingManagerView()){
                            ManagerOrderView()
                        }
                        NavigationLink(destination: LandingManagerView()){
                            ManagerOrderView()
                        }
                    }
                    HStack{
                        NavigationLink(destination: LandingManagerView()){
                            ManagerOrderView()
                        }
                        NavigationLink(destination: LandingManagerView()){
                            ManagerOrderView()
                        }
                    }
                    HStack{
                        NavigationLink(destination: LandingManagerView()){
                            ManagerOrderView()
                        }
                        NavigationLink(destination: LandingManagerView()){
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
