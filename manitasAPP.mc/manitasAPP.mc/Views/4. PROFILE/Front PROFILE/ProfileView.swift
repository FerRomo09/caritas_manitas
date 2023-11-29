//
//  ProfileView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 19/10/23.
//

import SwiftUI

struct ProfileView: View {
    @State private var logOut=false
    @State private var showingLogoutAlert = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            HStack {
                Button("← Regresar") {
                    dismiss()
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            VStack{
                VStack {
                    let user=curretUser
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
                                Text("Teléfono")
                                Spacer()
                                Text(user.tel)
                            }
                            Divider()
                            
                            HStack{
                                Text("Género")
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
                    
                    Button(action: {
                        self.showingLogoutAlert = true
                    }){
                        Text("**Cerrar Sesión**                            ")
                    }
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .padding(.top,10)
                    .navigationDestination(isPresented: $logOut){
                        ContentView()
                        .navigationBarBackButtonHidden(true)
                    }
                    
                    
                    .padding()
                }
                .padding(.horizontal, 20)
            }
            .alert(isPresented: $showingLogoutAlert) {
                Alert(title: Text("Cerrar Sesión"), message: Text("¿Estás seguro de que quieres cerrar la sesión?"), primaryButton: .destructive(Text("Cerrar Sesión")) {
                    UserDefaults.standard.set("", forKey: "token")
                    token=""
                    logOut=true
                }, secondaryButton: .cancel())
            }
        }
        
    } 
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
