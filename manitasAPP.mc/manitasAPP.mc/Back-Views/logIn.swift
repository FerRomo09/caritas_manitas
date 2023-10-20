import Foundation

let loginUrl = URL(string: "http://10.22.137.222:8037/check_login")!

let loginData: [String: Any] = [
    "username": "LICHEN",
    "password": "12345"
]

do {
    let jsonData = try JSONSerialization.data(withJSONObject: loginData, options: [])
    var request = URLRequest(url: loginUrl)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    
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

                            if let message = response["message"] as? String {
                                print("Response Message: \(message)")
                            }
                            
                            if let id = response["id"] as? Int {
                                print("User ID: \(id)")
                            }
                            
                            if let rol = response["rol"] as? Int {
                                print("User Role: \(rol)")
                            }
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
    }
    task.resume()
    
} catch {
    print("Error creating JSON data: \(error)")
}
