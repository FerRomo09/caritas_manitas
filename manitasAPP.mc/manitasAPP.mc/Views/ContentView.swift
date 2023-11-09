//
//  ContentView.swift
//  manitasAPP.mc
//
//  Created by Romo
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showAlert: Bool = false
    @State private var navigationToMain: Bool = false
    @State private var rolUser: Int = -1
    @State private var Token: String = " "

    var body: some View {
        NavigationStack {
            ZStack {
                Color("manitasAzul")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer().frame(height: 120)
                    
                    Image("logoCaritasBlanco")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 220)

                    ZStack {
                        Image("CuadroLI")
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 320, height: 500)
                            .shadow(color: Color("manitasAzulFuerte"), radius: 10, x: 2, y: 10)
                        VStack {
                            //Spacer().frame(height: 10)
                            Text("INICIA SESIÓN")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(Color("manitasAzulFuerte"))
                            Text("¡Bienvenid@! Ingresa tu usuario y contraseña para ingresar a tu cuenta.")
                                .font(.footnote)
                                .fontWeight(.thin)
                                .foregroundColor(Color("manitasAzulFuerte"))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 70)
                            Spacer().frame(height: 40)
                            
                            VStack(alignment: .leading) {
                                Text("Usuario:")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("manitasNegro"))
                                TextField("Escribe Aquí", text: $username)
                                    .textFieldStyle(.roundedBorder)
                                    .autocapitalization(.none)
                                Spacer().frame(height: 15)
                                Text("Contraseña:")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("manitasNegro"))
                                HStack{
                                    if showPassword {
                                        TextField("Escribe Aquí", text: $password)
                                            .textFieldStyle(.roundedBorder)
                                            .autocapitalization(.none)
                                    } else {
                                        SecureField("Escribe Aquí", text: $password)
                                            .textFieldStyle(.roundedBorder)
                                            .autocapitalization(.none)
                                    }
                                    //Spacer().frame(height: 10)
                                    Button(action: {
                                        showPassword.toggle()
                                    }) {
                                        Image(systemName: showPassword ? "eye.slash" : "eye")
                                    }.foregroundColor(Color("manitasMorado"))
                                }
                            }.padding(.horizontal, 60)
                            
                            
                            Spacer().frame(height: 25)
                            
                            Button(action: {
                                var logInRes: logInInfo
                                logInRes=checkLogIn(user: username, pass: password)
                                navigationToMain = logInRes.res
                                rolUser=logInRes.rol!
                                showAlert = !navigationToMain}){
                                    Text("INGRESAR")
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 90)
                                        .padding(.vertical, 8)
                                        .foregroundColor(Color("manitasBlanco"))
                                        .cornerRadius(10)
                                }
                            .tint(Color("manitasMorado"))
                            .buttonStyle(.borderedProminent)
                            .navigationDestination(isPresented: $navigationToMain){
                                    LandingView()
                            .navigationBarBackButtonHidden(true)
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Error"), message: Text("Usuario o contraseña incorrectos"), dismissButton: .default(Text("Ok")))
                            }
                            

                            
                        }
                    }
                    .padding(.horizontal, 20)
                    /*
                    ZStack {
                        Image("Cuadro")
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 500)
                            .shadow(color: Color("manitasAzulFuerte"), radius: 10, x: 2, y: 10)
                        
                        VStack {
                            Text("INICIA SESIÓN")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(Color("manitasAzulFuerte"))
                            Text("¡Bienvenid@! Ingresa tu usuario y contraseña para ingresar a tu cuenta.")
                                .font(.footnote)
                                .fontWeight(.thin)
                                .foregroundColor(Color("manitasAzulFuerte"))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 70)
                            Spacer().frame(height: 40)
                            
                            VStack(alignment: .leading) {
                                Text("Usuario:")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("manitasNegro"))
                                TextField("Escribe Aquí", text: $username)
                                    .textFieldStyle(.roundedBorder)
                                    .autocapitalization(.none)
                                Spacer().frame(height: 25)
                                Text("Contraseña:")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("manitasNegro"))
                                if showPassword {
                                    TextField("Escribe Aquí", text: $password)
                                        .textFieldStyle(.roundedBorder)
                                        .autocapitalization(.none)
                                } else {
                                    SecureField("Escribe Aquí", text: $password)
                                        .textFieldStyle(.roundedBorder)
                                        .autocapitalization(.none)
                                }
                                Spacer().frame(height: 10)
                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash" : "eye")
                                }.foregroundColor(Color("manitasMorado"))
                            }.padding(.horizontal, 50)
                            Spacer().frame(height: 35)
                            
                            Button(action: {
                                var logInRes: logInInfo
                                logInRes=checkLogIn(user: username, pass: password)
                                navigationToMain = logInRes.res
                                rolUser=logInRes.rol!
                                idEmpleado=logInRes.id!
                                showAlert = !navigationToMain}){
                                    Text("INGRESAR")
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 90)
                                        .padding(.vertical, 8)
                                        .foregroundColor(Color("manitasBlanco"))
                                        .cornerRadius(10)
                                }
                            .tint(Color("manitasMorado"))
                            .buttonStyle(.borderedProminent)
                            .navigationDestination(isPresented: $navigationToMain){
                                    LandingView()
                            .navigationBarBackButtonHidden(true)
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Error"), message: Text("Usuario o contraseña incorrectos"), dismissButton: .default(Text("Ok")))
                            }
                            

                            Spacer().frame(height: 20)
                        }
                    }*/
                    Spacer()
                    Image("FotoManos")
                    
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
    }

    func autenticarEjemplo() ->Bool {
        if username == "admin" && password == "admin123" {
            return true
        } else {
            return false
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
