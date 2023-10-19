// Autor: Fernanda Romo

import SwiftUI

struct LogInView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showAlert: Bool = false
    @State private var navigationToMain: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("manitasAzul")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer().frame(height: 40)
                    
                    Image("logoCaritasBlanco")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140)
                    Spacer().frame(height: 0)
                    
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
                            
                            Button(action: autenticarEjemplo) {
                                Text("INGRESAR")
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 90)
                                    .padding(.vertical, 8)
                                    .foregroundColor(Color("manitasBlanco"))
                                    .cornerRadius(10)
                            }
                            .tint(Color("manitasMorado"))
                            .buttonStyle(.borderedProminent)
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Error"), message: Text("Usuario o contraseña incorrectos"), dismissButton: .default(Text("Ok")))
                            }

                            Spacer().frame(height: 20)
                        }
                    }
                    Spacer()
                }
                
                // NavigationLink oculto para la navegación programática
                NavigationLink("", destination: profileView(), isActive: $navigationToMain)
                    .hidden()
            }
        }
    }

    func autenticarEjemplo() {
        if username == "admin" && password == "password123" {
            navigationToMain = true  // Activa la navegación programática a ContentView
            print("Usuario autenticado correctamente")
        } else {
            showAlert = true
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
