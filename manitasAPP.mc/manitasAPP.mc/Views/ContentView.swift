import SwiftUI

var apiUrl = "http://10.22.137.191:8037"
var curretUser = User(name: "", lastName: "", email: "", tel: "", gen: 0, fechaNacimiento: "")

struct ContentView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showAlert: Bool = false
    @State private var navigationToMain: Bool = false
    @State private var rolUser: Int = -1
    @State private var token: String = ""

    var body: some View {
    
        NavigationStack {
            if !navigationToMain {
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
                                    logInRes = checkLogIn(user: username, pass: password)
                                    navigationToMain = logInRes.res
                                    rolUser = logInRes.rol!
                                    UserDefaults.standard.set(logInRes.token, forKey: "token")
                                    if logInRes.res {
                                        getUser(token: UserDefaults.standard.string(forKey: "token")) { user in
                                            if let user = user {
                                                self.curretUser = user
                                            } else {
                                                print("no user data")
                                            }
                                        }
                                    }
                                    showAlert = !navigationToMain
                                }) {
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
                                .navigationBarBackButtonHidden(true)
                            }
                        }
                        .padding(.horizontal, 20)
                        Spacer()
                        Image("FotoManos")
                    }
                    .edgesIgnoringSafeArea(.all)
                }
                .onAppear {
                    // Check if the user token is valid
                    let token = UserDefaults.standard.string(forKey: "token") ?? ""
                    do {
                        try getUser(token: token) { user in
                            if let user = user {
                                self.curretUser = user
                                // If the user is logged in, go to the main view
                                navigationToMain = true
                                self.token = token
                            }
                        }
                    } catch {
                        // If there's an error (e.g., token is invalid), go to the login view
                        navigationToMain = false
                    }
                }
            } else {
                NavigationLink(
                    destination: LandingView(nombreRecibido: username, tokenRecibido: token),
                    isActive: $navigationToMain,
                    label: { EmptyView() }
                )
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
