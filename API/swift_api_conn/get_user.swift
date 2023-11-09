import Foundation

struct User {
    let id: Int
    let name: String
    let email: String
    let 
}

func getUser(completion: @escaping (User?) -> User) {
    let getUserUrl = URL(string: "http://10.22.137.222:8037/get_user")!
    
    var request = URLRequest(url: getUserUrl)
    request.httpMethod = "POST"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                        
                        if let user = json as? [String: Any] {
                            let id = user["id"] as? Int ?? 0
                            let name = user["nombre"] as? String ?? ""
                            let email = user["email"] as? String ?? ""
                            completion(User(id: id, name: name, email: email))
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
        group.leave()
    }
    
    task.resume()
    group.wait()
}