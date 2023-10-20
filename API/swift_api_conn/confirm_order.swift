import Foundation

let loginUrl = URL(string: "http://10.22.137.222:8037/check_login")!

let orderConfirmationData: [String: Any] = [
    "newPagoTemp": 1,
    "newPagoFin": 2
]

do {
    let jsonData = try JSONSerialization.data(withJSONObject: orderConfirmationData, options: [])
        
    var request = URLRequest(url: confirmOrderUrl)
    request.httpMethod = "PUT"
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
                //hacer algo si si sirvió
                print("Order confirmed")
            } else if statusCode == 404 {
                print("Order not found")
            }
        }
    }
    
    task.resume()
    
} catch {
    print("Error creating JSON data: \(error)")
}
