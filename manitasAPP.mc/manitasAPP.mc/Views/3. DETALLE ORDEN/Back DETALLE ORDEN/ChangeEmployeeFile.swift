import Foundation

func changeEmployeeOrder(orderID: Int, empID: Int) {
    
    let changeOrderUrl = URL(string: "\(apiUrl)/change_emp_order/\(orderID)/\(empID)")!

    var request = URLRequest(url: changeOrderUrl)
    request.httpMethod = "PUT"

    // Set the Authorization header with the Bearer token
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error)")
            return
        }

        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            print("HTTP Status Code: \(statusCode)")

            if statusCode == 200 {
                print("Order confirmed successfully")
            } else if statusCode == 404 {
                print("Order not found")
            } else {
                print("Error")
            }
        }
    }

    task.resume()
}
