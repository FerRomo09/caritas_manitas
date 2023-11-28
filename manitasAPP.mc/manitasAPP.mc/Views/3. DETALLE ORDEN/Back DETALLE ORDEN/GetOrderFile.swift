//
//  GetOrdenFile.swift
//
//  Created by Jacobo Hirsch on 22/11/23.
//
import Foundation

struct OrdenesResponse: Decodable {
    let mensaje: String
    let list: [Orden]

    enum CodingKeys: String, CodingKey {
        case mensaje =  "mensaje"
        case list = "list"
    }
}


struct ReprogramacionInfo: Encodable {
    let comentarios: String
}

struct Orden: Decodable {
    var idOrden: Int64
    var fechaCobro: Date?
    var fechaPago: Date?
    var importe: Double?
    var estatusOrden: Int64?
    var comentarios: String?
    var comentariosReprogramacion: String?
    var nombre: String?
    var apellidoPaterno: String
    var apellidoMaterno: String?
    var callePrincipal: String
    var numeroExterior: Int64
    var colonia: String
    var codigoPostal: Int64
    var municipio: String?
    
    //Formateo de importe
    var importeFormateado: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."

        return formatter.string(from: NSNumber(value: self.importe ?? 0.0)) ?? "0,00"
    }
    

    enum CodingKeys: String, CodingKey {
        case idOrden = "id"
        case fechaCobro = "FECHA_COBRO"
        case fechaPago = "FECHA_PAGO"
        case importe = "IMPORTE"
        case estatusOrden = "ESTATUS_ORDEN"
        case comentarios = "COMENTARIOS"
        case comentariosReprogramacion = "COMENTARIOS_REPROGRAMACION"
        case nombre = "NOMBRE"
        case apellidoPaterno = "A_PATERNO"
        case apellidoMaterno = "A_MATERNO"
        case callePrincipal = "CALLE_PRINCIPAL"
        case numeroExterior = "NUM_EXT"
        case colonia = "COLONIA"
        case codigoPostal = "CODIGO_POST"
        case municipio = "MUNICIPIO"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idOrden = try container.decode(Int64.self, forKey: .idOrden)

        // Convertir fecha de String a Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let fechaCobroStr = try container.decodeIfPresent(String.self, forKey: .fechaCobro) {
            fechaCobro = dateFormatter.date(from: fechaCobroStr)
        }
        if let fechaPagoStr = try container.decodeIfPresent(String.self, forKey: .fechaPago) {
            fechaPago = dateFormatter.date(from: fechaPagoStr)
        }

        importe = try container.decodeIfPresent(Double.self, forKey: .importe)
        estatusOrden = try container.decodeIfPresent(Int64.self, forKey: .estatusOrden)
        comentarios = try container.decodeIfPresent(String.self, forKey: .comentarios)
        comentariosReprogramacion = try container.decodeIfPresent(String.self, forKey: .comentariosReprogramacion)
        nombre = try container.decodeIfPresent(String.self, forKey: .nombre)
        apellidoPaterno = try container.decode(String.self, forKey: .apellidoPaterno)
        apellidoMaterno = try container.decodeIfPresent(String.self, forKey: .apellidoMaterno)
        callePrincipal = try container.decode(String.self, forKey: .callePrincipal)
        numeroExterior = try container.decode(Int64.self, forKey: .numeroExterior)
        colonia = try container.decode(String.self, forKey: .colonia)
        codigoPostal = try container.decode(Int64.self, forKey: .codigoPostal)
        municipio = try container.decodeIfPresent(String.self, forKey: .municipio)
    }

}

func fetchOrders(forEmployeeID employeeID: Int, forEstatusId StatusId: Int, completion: @escaping ([Orden]) -> Void) {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let today = dateFormatter.string(from: Date())
    //print(type(of: today))
    
    let urlString = "http://10.22.131.171:8037/ordenes/\(employeeID)/\(StatusId)?fecha=\(today)"
    guard let url = URL(string: urlString) else {
        print("URL inválida")
        completion([])
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        // Verificar si hay errores
        if let error = error {
            print("Error al obtener datos: \(error)")
            completion([])
            return
        }

        // Verificar si los datos no son nulos
        guard let data = data else {
            print("Datos no recibidos")
            completion([])
            return
        }
        
        
        /*
        // Imprimir los datos en bruto como String
         if let rawResponse = String(data: data, encoding: .utf8) {
             print("Respuesta en bruto: \(rawResponse)")
         }
         */
        
        
        do {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
        
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            let ordenesResponse = try decoder.decode(OrdenesResponse.self, from: data)
            let ordenes = ordenesResponse.list

            print("Ordenes decodificadas: \(ordenes)")
            
            print(type(of: ordenes))
            
            print(type(of: ordenes[0]))
            
            
            print(ordenes[0].idOrden)
            
            print(ordenes[0].importe ?? 0.0)
            
            print("cp")
            print(ordenes[0].codigoPostal)
            
   
            completion(ordenes)

        } catch {
            print("Error al decodificar los datos: \(error)")
            completion([])
        }
        
    }
    
    task.resume()
}


// Extensión para crear una instancia de ejemplo de 'Orden'
extension Orden {
    init(idOrden: Int64, fechaCobro: Date?, fechaPago: Date?, importe: Double?, estatusOrden: Int64?, comentarios: String?, comentariosReprogramacion: String?, nombre: String?, apellidoPaterno: String, apellidoMaterno: String?, callePrincipal: String, numeroExterior: Int64, colonia: String, codigoPostal: Int64, municipio: String?) {
        self.idOrden = idOrden
        self.fechaCobro = fechaCobro
        self.fechaPago = fechaPago
        self.importe = importe
        self.estatusOrden = estatusOrden
        self.comentarios = comentarios
        self.comentariosReprogramacion = comentariosReprogramacion
        self.nombre = nombre
        self.apellidoPaterno = apellidoPaterno
        self.apellidoMaterno = apellidoMaterno
        self.callePrincipal = callePrincipal
        self.numeroExterior = numeroExterior
        self.colonia = colonia
        self.codigoPostal = codigoPostal
        self.municipio = municipio
    }

    static var ejemplo: Orden {
        return Orden(
            idOrden: 12345,
            fechaCobro: Date(),
            fechaPago: Date(),
            importe: 1000.0,
            estatusOrden: 1,
            comentarios: "Comentario de ejemplo",
            comentariosReprogramacion: "Reprogramación Ejemplo",
            nombre: "Nombre Ejemplo",
            apellidoPaterno: "Apellido P Ejemplo",
            apellidoMaterno: "Apellido M Ejemplo",
            callePrincipal: "Calle Ejemplo",
            numeroExterior: 742,
            colonia: "Colonia ejemplo",
            codigoPostal: 12345,
            municipio: "Ciudad Ejemplo"
        )
    }
}


func reprogramOrder(orderID: Int, reprogramacionInfo: ReprogramacionInfo, completion: @escaping (Bool, String) -> Void) {
    let urlString = "http://10.22.131.171:8037/reprogram_order/\(orderID)"
    guard let url = URL(string: urlString) else {
        print("URL inválida")
        completion(false, "URL inválida")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        let jsonData = try JSONEncoder().encode(reprogramacionInfo)
        request.httpBody = jsonData
    } catch {
        print("Error al codificar los datos: \(error)")
        completion(false, "Error al codificar los datos")
        return
    }

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error al realizar la solicitud: \(error)")
            completion(false, "Error al realizar la solicitud")
            return
        }

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Respuesta no exitosa del servidor")
            completion(false, "Respuesta no exitosa del servidor")
            return
        }

        completion(true, "Reprogramación exitosa")
    }
    
    task.resume()
}


func confirmOrder(orderID: Int, completion: @escaping (Bool, String) -> Void) {
    let urlString = "http://10.22.131.171:8037/confirm_order/\(orderID)"
    guard let url = URL(string: urlString) else {
        print("URL inválida")
        completion(false, "URL inválida")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "PUT"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error al realizar la solicitud: \(error)")
            completion(false, "Error al realizar la solicitud")
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            completion(false, "Respuesta no exitosa del servidor")
            return
        }

        if httpResponse.statusCode == 200 {
            completion(true, "Orden confirmada exitosamente")
        } else if httpResponse.statusCode == 404 {
            completion(false, "Orden no encontrada")
        } else {
            completion(false, "Error del servidor")
        }
    }
    
    task.resume()
}
