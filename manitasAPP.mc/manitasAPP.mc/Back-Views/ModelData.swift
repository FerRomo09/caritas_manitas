//
//  ModelData.swift
//  ProbarAPIRomo
//
//  Created by Romo on 17/10/23.
//

import Foundation
/*
func CallAPIUsuarios() -> Array<Usuario>{ // Regresar toda la lista POST
    var usuariosList: Array<Usuario> = []
    guard let url = URL(string:"http://10.14.255.83:8088/users") else{
        print("No pude asignar el URLD del API")
        return usuariosList
    }
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: url){ data, response, error in
        let jsonDecoder = JSONDecoder()
        if (data != nil){
            
            do{ // objeto de tipo post para hacer algo
                usuariosList = try jsonDecoder.decode([Usuario].self, from: data!) // le damos la estructura de datos que queremos utilizar
                for usuarioItem in usuariosList{
                    print("Id: \(usuarioItem.id) - User: \(usuarioItem.User) -Email: \(usuarioItem.email)")
                }
            }catch{
                print(error)
            }
            group.leave()
        }
    }
    task.resume()
    group.wait()
    print("******** Saliendo de la función.")
    return usuariosList
}


func CallAPIList() -> Array<Post>{ // Regresar toda la lista POST
    var postList: Array<Post> = []
    guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts") else{
        print("No pude asignar el URLD del API")
        return postList
    }
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: url){ data, response, error in
        let jsonDecoder = JSONDecoder()
        if (data != nil){
            
            do{ // objeto de tipo post para hacer algo
                postList = try jsonDecoder.decode([Post].self, from: data!) // le damos la estructura de datos que queremos utilizar
                for postItem in postList{
                    print("Id: \(postItem.id) - Titulo: \(postItem.title) ")
                }
            }catch{
                print(error)
            }
            group.leave()
        }
    }
    task.resume()
    group.wait()
    print("******** Saliendo de la función.")
    return postList
}

func CallAPI() { // Regresar un elemento (solo 1)
    guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts/1") else{
        print("No pude asignar el URLD del API")
        return
    }
    
    // Abre un task y llama a la API de arriba
    let task = URLSession.shared.dataTask(with: url){ data, response, error in
        let jsonDecoder = JSONDecoder()
        
        if (data != nil){
            //if let datosAPI = String(data: data!, encoding: .utf8){ // leer textualmente todo lo del json.
            //        print(datosAPI)
            //}
            do{ // objeto de tipo post para hacer algo
                let postItem = try jsonDecoder.decode(Post.self, from: data!) // le damos la estructura de datos que queremos utilizar
                print("Id: \(postItem.id) - Titulo: \(postItem.title) ")
            }catch{
                print(error)
            }
        }
    }
    
    task.resume()
    print("******** Saliendo de la función.")
    return
}


struct Post:Codable, Identifiable{ // Protocolo para convertir del JSON  a estructura de datos automáticamente, Identifiable para hacer una lista
    var userId: Int
    var id: Int
    var title: String
    var body: String
}


struct Usuario:Codable, Identifiable{
    var ID: Int
    var User: String
    var email: String
    var id: Int {
        return self.ID
    }//porque el protocolo identifiable lo amerita en minusculas
}
 */
