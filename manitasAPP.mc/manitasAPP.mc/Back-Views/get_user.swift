import Foundation

let loginUrl = URL(string: "http://10.22.137.222:8037/check_login")!

let session = URLSession.shared

let task = session.dataTask(with: getUserUrl) { data, response, error in
    if let error = error {
        print("Error: \(error)")
        return
    }
    
    if let httpResponse = response as? HTTPURLResponse {
        // Check the HTTP status code
        let statusCode = httpResponse.statusCode
        print("HTTP Status Code: \(statusCode)")
        
        if statusCode == 200 {
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    if let user = json as? [String: Any] {
                        //faltan otros y usar struct?
                        let userId = user["id"] as? Int
                        let firstName = user["nombre"] as? String
                        let email = user["email"] as? String                  
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        } else if statusCode == 404 {
            print("User not found")
        } else {
            print("Error")
            
        }
    }
}

// Start the data task
task.resume()
