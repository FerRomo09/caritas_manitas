//
//  ProfileView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 19/10/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
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
                    Divider()

                }
                .padding()
                .background(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .offset(y:-80)
            
            
            
            Button("Cerrar sesion"){
                
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            

            
            

            
           
          
            
           
        }
        .padding()
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
