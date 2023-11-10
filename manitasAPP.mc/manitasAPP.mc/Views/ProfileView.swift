//
//  ProfileView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 19/10/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var curretUser: User?
    @State private var isLoading = false
    var token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiMSIsInVzZXJuYW1lIjoiZW1wSnVhblAifSwiZXhwIjoxNzAzODczODQ5fQ.PDsknvxTskMKGtEpHw8_pX4HFiv3cWoMqazNP6qUUlc"
    
    var body: some View {
        NavigationStack{
            VStack{
                if isLoading{
                    Text("Cargando...")
                }
                else if let user=curretUser{
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
                                Text(user.name)
                                
                                
                            }
                            Divider()
                            
                            HStack{
                                Text("Apellidos")
                                Spacer()
                                Text(user.lastName)
                            }
                            Divider()
                            
                            HStack{
                                Text("Email")
                                Spacer()
                                Text(user.email)
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
                                Text(user.tel)
                            }
                            Divider()
                            
                            HStack{
                                Text("Genero")
                                Spacer()
                                if user.gen==1{
                                    Text("Masculino")
                                }
                                else{
                                    Text("Femenino")
                                }
                                    
                            }
                            Divider()
                            
                            HStack{
                                Text("Fecha Nacimiento")
                                Spacer()
                                Text(user.fechaNacimiento)
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
                    .navigationBarBackButtonHidden(true)
                    
                    
                    
                    /*
                     Button("Cerrar sesion"){
                     
                     }
                     .buttonStyle(.borderedProminent)
                     .tint(.red)
                     */
                    
                }
                else {
                    Text("Error cargando datos")
                }
            }

            .padding()
            
            .onAppear{
                isLoading=true
                getUser(token: token){user in
                    isLoading=false
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
