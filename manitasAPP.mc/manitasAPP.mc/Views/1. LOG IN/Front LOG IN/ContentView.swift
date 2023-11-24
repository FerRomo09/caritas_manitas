import SwiftUI
import Network

var apiUrl = "http://10.22.163.85:8037"
var curretUser = User(name: "test", lastName: "", email: "", tel: "", gen: 0, fechaNacimiento: "")
var token = ""

enum ActiveAlert {
    case offline, wrongCredentials
}

func checkConnection(completion: @escaping (Bool) -> Void) {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    let semaphore = DispatchSemaphore(value: 0)
    
    monitor.start(queue: queue)
    
    monitor.pathUpdateHandler = { path in
        if path.status == .satisfied {
            // Internet connection is available
            // Now check for API response
            guard let url = URL(string: "\(apiUrl)/connectivity") else {
                completion(false)
                semaphore.signal()
                return
            }
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 2 // Set your desired timeout interval here
            let session = URLSession(configuration: configuration)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    completion(false)
                } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    // API responded successfully
                    completion(true)
                    print("succes")
                } else {
                    completion(false)
                }
                semaphore.signal()
            }
            task.resume()
        } else {
            // No internet connection
            completion(false)
            semaphore.signal()
        }
    }
    semaphore.wait()
}

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var navigationToMain: Bool = false
    @State private var alreadyLogedIn: Bool = false
    @State private var rolUser: Int = -1
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .offline

    var body: some View {
    
        NavigationStack {
            if !alreadyLogedIn {
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
                                    checkConnection { connected in
                                        if !connected {
                                            // No internet connection
                                            showAlert=true
                                            self.activeAlert = .offline
                                            
                                        } else {
                                            var logInRes: logInInfo
                                            logInRes = checkLogIn(user: username, pass: password)
                                            navigationToMain = logInRes.res
                                            rolUser = logInRes.rol!
                                            token = logInRes.token!
                                            UserDefaults.standard.set(token, forKey: "token")
                                            UserDefaults.standard.set(rolUser, forKey: "rol")
                                            if logInRes.res {
                                                getUser(token: UserDefaults.standard.string(forKey: "token")!) { user in
                                                    if let user = user {
                                                        curretUser = user
                                                        UserDefaults.standard.set(user.name, forKey: "name")
                                                        UserDefaults.standard.set(user.lastName, forKey: "lastName")
                                                        UserDefaults.standard.set(user.email, forKey: "email")
                                                        UserDefaults.standard.set(user.tel, forKey: "tel")
                                                        UserDefaults.standard.set(user.gen, forKey: "gen")
                                                        UserDefaults.standard.set(user.fechaNacimiento, forKey: "fechaNacimiento")
                                                        
                                                    } else {
                                                        print("no user data")
                                                    }
                                                }
                                            }
                                            showAlert = !navigationToMain
                                            if !navigationToMain {
                                                activeAlert = .wrongCredentials
                                            }
                                        }
                                    }
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
                                .navigationDestination(isPresented: $navigationToMain){
                                    if (rolUser==1){
                                        ManagerView()
                                    }else{
                                        LandingView()
                                    }
                                }
                                .navigationBarBackButtonHidden(true)
                                .alert(isPresented: $showAlert) {
                                    switch activeAlert {
                                    case .offline:
                                        return Alert(title: Text("Error"), message: Text("No hay conexión a internet"), dismissButton: .default(Text("Ok")))
                                    case .wrongCredentials:
                                        return Alert(title: Text("Error"), message: Text("Usuario o contraseña incorrectos"), dismissButton: .default(Text("Ok")))
                                    }
                                    
                                    
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        Spacer()
                        Image("FotoManos")
                    }
                    .edgesIgnoringSafeArea(.all)
                }
                .onAppear {
                    // Check if theres internet connection
                    // if theres  no internet connection, check if theres a token stored, if there is one, load the user data from user defaults and send them to the correct view
                    // if theres no token stored, show and alert
                    // if theres internet connection, check if theres a token stored, if there is one, check if its valid, if its valid, load the user data from the api and send them to the correct view
                    // if theres no token stored, send them to the login view
                    checkConnection { connected in
                        if !connected {
                            // No internet connection
                            // Check if theres a token stored
                            let Token = UserDefaults.standard.string(forKey: "token") ?? ""
                            if Token != "" {
                                // Token stored
                                // Load the user data from user defaults
                                let name = UserDefaults.standard.string(forKey: "name") ?? ""
                                let lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
                                let email = UserDefaults.standard.string(forKey: "email") ?? ""
                                let tel = UserDefaults.standard.string(forKey: "tel") ?? ""
                                let gen = UserDefaults.standard.integer(forKey: "gen")
                                let fechaNacimiento = UserDefaults.standard.string(forKey: "fechaNacimiento") ?? ""
                                let user = User(name: name, lastName: lastName, email: email, tel: tel, gen: gen, fechaNacimiento: fechaNacimiento)
                                token = Token
                                curretUser = user
                                alreadyLogedIn = true
                            } else {
                                // No token stored
                                // Show an alert that theres no internet connection and no prev log in
                                alreadyLogedIn = false
                                showAlert = true
                                activeAlert = .offline
                            }
                        } else {
                            // Internet connection available
                            // Check if theres a token stored
                            let Token = UserDefaults.standard.string(forKey: "token") ?? ""
                            if Token != "" {
                                // Token stored
                                // Check if the token is valid
                                getUser(token: Token) { user in
                                    if let user = user {
                                        // Token is valid
                                        // Load the user data from the api
                                        curretUser = user
                                        token = Token
                                        alreadyLogedIn = true
                                    } else {
                                        // Token is not valid
                                        alreadyLogedIn = false
                                    }
                                }
                            } else {
                                // No token stored
                                // Send them to the login view
                                alreadyLogedIn = false
                            }
                        }
                    }
                }   
            }else {
                if UserDefaults.standard.integer(forKey: "rol")==1{
                    ManagerView()
                }else{
                    LandingView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
