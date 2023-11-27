import Foundation
import Network

struct logInInfo{
    var res: Bool
    var rol: Int?
    var token: String?
}

func checkLogIn(user: String, pass: String)->logInInfo {
    
    let loginUrl = URL(string: "\(apiUrl)/check_login")!
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
                    print("Wrong password")
                }
                else if statusCode == 404{
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

func checkConnection(completion: @escaping (Bool) -> Void) {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    let semaphore = DispatchSemaphore(value: 0)
    
    monitor.start(queue: queue)
    
    monitor.pathUpdateHandler = { path in
        if path.status == .satisfied {
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
                    completion(true)
                    print("succes")
                } else {
                    completion(false)
                }
                semaphore.signal()
            }
            task.resume()
        } else {
            completion(false)
            semaphore.signal()
        }
    }
    semaphore.wait()
}
