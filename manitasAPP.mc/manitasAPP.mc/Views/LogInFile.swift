import Foundation

struct logInInfo{
    var res: Bool
    var rol: Int?
    var token: String?
}

func checkLogIn(user: String, pass: String)->logInInfo {
    
    let loginUrl = URL(string: "http://10.22.226.64:8037/check_login")!
    var logD = logInInfo(res:false, rol:0, token:"")
    
    let loginData: [String: Any] = [
        "username": user,
        "password": pass
    ]
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: loginData, options: [])
        var request = URLRequest(url: loginUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let group = DispatchGroup()
        group.enter()
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                
                let statusCode = httpResponse.statusCode
                print("HTTP Status Code: \(statusCode)")
                
                if statusCode == 200 {
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            
                            if let response = json as? [String: Any] {
                                //hacer algo si fue exitoso
                                logD.rol = response["rol"] as? Int
                                logD.token = response["token"] as? String
                                logD.res=true
                            }
                        } catch {
                            print("Error parsing JSON: \(error)")
                        }
                    }
                }
                else if statusCode == 401{
                    //hacer algo si no la clave esta incorrecta
                    print("Wrong password")
                }
                else if statusCode == 404{
                    //hacer algo si no existe el usuario
                    print("User not found")
                }
                else{
                    print("Error")
                }
            }
            group.leave()
        }
        
        task.resume()
        group.wait()
        
        
    } catch {
        print("Error creating JSON data: \(error)")
    }
    return logD
}
