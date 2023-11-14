//
//  ManagerProfileView.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 10/11/23.
//

import SwiftUI

struct ManagerProfileView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("manitasAzul"), lineWidth: 2))
                    .shadow(radius: 5)
                
                Spacer()
                
                VStack{
                    VStack{
                        HStack{
                            Text("Nombre(s)")
                            Spacer()
                            //Text(user.name)
                            
                            
                        }
                        Divider()
                        
                        HStack{
                            Text("Apellidos")
                            Spacer()
                            //Text(user.lastName)
                        }
                        Divider()
                        
                        HStack{
                            Text("Email")
                            Spacer()
                            //Text(user.email)
                        }
                        
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .offset(y:-130)
                
                VStack{
                    VStack{
                        HStack{
                            Text("Telefono")
                            Spacer()
                            //Text(user.tel)
                        }
                        Divider()
                        
                        HStack{
                            Text("Genero")
                            Spacer()
                            /*
                            if user.gen==1{
                                Text("Masculino")
                            }
                            else{
                                Text("Femenino")
                            }
                            */
                        }
                        Divider()
                        
                        HStack{
                            Text("Fecha Nacimiento")
                            Spacer()
                            //Text(user.fechaNacimiento)
                        }
                        Divider()
                        
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .offset(y:-80)
                
                //REVISAR
                
                NavigationLink("Cerrar sesion"){
                    ContentView()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .padding(.top,10)
                    
                }
 
            }

            .padding()
            
    }
}


struct ManagerProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ManagerProfileView()
    }
}
