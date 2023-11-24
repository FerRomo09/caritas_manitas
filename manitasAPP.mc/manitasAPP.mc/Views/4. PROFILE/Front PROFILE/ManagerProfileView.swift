//
//  ManagerProfileView.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 10/11/23.
//

/*
import SwiftUI

struct ManagerProfileView: View {
    @State private var showingLogoutAlert = false
    @State private var navigateToContentView = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button("← Regresar") {
                        dismiss()
                    }
                    Spacer()
                }
                .padding(.horizontal, 30)
                
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("manitasAzul"), lineWidth: 2))
                    .shadow(radius: 5)

                Spacer()

                VStack {
                    VStack {
                        HStack {
                            Text("Nombre(s)")
                            Spacer()
                            // Text(user.name)
                        }
                        Divider()

                        HStack {
                            Text("Apellidos")
                            Spacer()
                            // Text(user.lastName)
                        }
                        Divider()

                        HStack {
                            Text("Email")
                            Spacer()
                            // Text(user.email)
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .offset(y: -130)

                VStack {
                    VStack {
                        HStack {
                            Text("Telefono")
                            Spacer()
                            // Text(user.tel)
                        }
                        Divider()

                        HStack {
                            Text("Genero")
                            Spacer()
                        }
                        Divider()

                        HStack {
                            Text("Fecha Nacimiento")
                            Spacer()
                        }
                        Divider()
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .offset(y: -80)

                Button("Cerrar sesión") {
                    showingLogoutAlert = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .padding(.top, 10)

                NavigationLink("", destination: ContentView(), isActive: $navigateToContentView)
                    .hidden()
            }
            .alert(isPresented: $showingLogoutAlert) {
                Alert(
                    title: Text("Confirmación"),
                    message: Text("¿Seguro que quieres cerrar sesión?"),
                    primaryButton: .destructive(Text("Sí")) {
                        navigateToContentView = true
                        // Colocar lógica para cerrar sesión
                    },
                    secondaryButton: .cancel()
                )
            }
            .padding()
        }
    }
}

struct ManagerProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ManagerProfileView()
    }
}
*/
