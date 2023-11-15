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
                                // ... Your existing code ...

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
