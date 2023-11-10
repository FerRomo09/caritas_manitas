import Foundation

struct OrderConfirmationResponse: Decodable {
    let message: String
}

func confirmOrder(orderID: Int, token: String, completion: @escaping (Result<OrderConfirmationResponse, Error>) -> Void) {
    let confirmOrderUrl = URL(string: "http://10.22.226.64:8037/confirm_order/\(orderID)")!

    var request = URLRequest(url: confirmOrderUrl)
    request.httpMethod = "PUT"

    // Set the Authorization header with the Bearer token
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
            return
        }

        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            print("HTTP Status Code: \(statusCode)")

            if statusCode == 200 {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(OrderConfirmationResponse.self, from: data)

                        DispatchQueue.main.async {
                            completion(.success(response))
                        }
                    } catch {
                        print("Error parsing JSON: \(error)")
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            } else if statusCode == 404 {
                print("Order not found")
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Order not found", code: statusCode, userInfo: nil)))
                }
            } else {
                print("Error")
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Unknown error", code: statusCode, userInfo: nil)))
                }
            }
        }
    }

    task.resume()
}
