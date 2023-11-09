//
//  ProfileView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 19/10/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var curretUser: User?
    var token: String?
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
                            Text("Andrea Alejandra")
                            
                            
                        }
                        Divider()
                        
                        HStack{
                            Text("Apellidos")
                            Spacer()
                            Text("Espindola Gomez")
                        }
                        Divider()
                        
                        HStack{
                            Text("Fecha de nacimiento")
                            Spacer()
                            Text("02/02/2002")
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
                            Text("------")
                            Spacer()
                            Text("-------")
                            
                            
                        }
                        Divider()
                        
                        HStack{
                            Text("-----")
                            Spacer()
                            Text("-------")
                        }
                        Divider()
                        
                        HStack{
                            Text("-------")
                            Spacer()
                            Text("-------")
                        }
                        Divider()
                        
                        HStack{
                            Text("Agregar")
                            Spacer()
                            Text("agregar")
                        }

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
                .navigationBarBackButtonHidden(true)
                
                
                
                /*
                Button("Cerrar sesion"){
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                */

            }
            .padding()
            
            .onAppear{
                getUser(token: token!){user in
                    if let user = user {
                        self.curretUser = user
                    }
                    else{
                        print("no user data")
                    }
                }
            }
            
        } 
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
