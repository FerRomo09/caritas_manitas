import Foundation
import Dispatch

struct User {
    let id: Int
    let name: String
    let lastName: String
    let email: String
    let tel: String
    let gen: Bool
}

func getUser(token: String, completion: @escaping (User?) -> Void) {
    let getUserUrl = URL(string: "http://10.22.137.222:8037/get_user")!
    
    var request = URLRequest(url: getUserUrl)
    request.httpMethod = "GET"
    
    // Set the Authorization header with the Bearer token
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let group = DispatchGroup()
    group.enter()

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        defer {
            group.leave()
        }

        if let error = error {
            print("Error: \(error)")
            completion(nil)
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            print("HTTP Status Code: \(statusCode)")
            
            if statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        if let userDict = json as? [String: Any] {

                            if let id = userDict["id"] as? Int,
                               let name = userDict["nombre"] as? String,
                               let lastName = userDict["apellido"] as? String,
                               let email = userDict["email"] as? String,
                               let tel = userDict["telefono"] as? String,
                               let gen = userDict["genero"] as? Bool {
                                
                                let user = User(id: id, name: name, lastName: lastName, email: email, tel: tel, gen: gen)
                                completion(user)
                            } else {
                                print("Error parsing user data")
                                completion(nil)
                            }
                        }
                    } catch {
                        print("Error parsing JSON: \(error)")
                        completion(nil)
                    }
                }
            } else if statusCode == 404 {
                print("User not found")
                completion(nil)
            } else {
                print("Error")
                completion(nil)
            }
        }
    }
    
    task.resume()
    group.wait()
}
