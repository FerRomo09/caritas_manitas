import Foundation

struct Empleado: Codable {
    let id: Int
    let nombre: String
    let num_ordenes: Int

    init(id: Int, nombre: String, numOrdenes: Int) {
        self.id = id
        self.nombre = nombre
        self.num_ordenes = numOrdenes
    }
}

func getEmpleados(completion: @escaping (Result<[Empleado], Error>) -> Void) {
    let getEmpleadosUrl = URL(string: "\(apiUrl)/get_empleados")!

    var request = URLRequest(url: getEmpleadosUrl)
    request.httpMethod = "GET"

    // Set the Authorization header with the Bearer token
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            if statusCode == 200 {
                // Parse the list of employees
                do {
                    if let data = data {
                        let empleadosList = try JSONDecoder().decode([Empleado].self, from: data)
                        completion(.success(empleadosList))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else if statusCode == 404 {
                completion(.failure(NSError(domain: "No employees found", code: 404, userInfo: nil)))
            } else {
                completion(.failure(NSError(domain: "Error", code: statusCode, userInfo: nil)))
            }
        }
    }

    task.resume()
}
