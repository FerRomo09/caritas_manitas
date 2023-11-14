//
//  ReciboFetch.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 12/11/23.
//

import Foundation


struct Orden:Decodable {
    let idOrden: Int64
    let idDonante: Int64
    var idEmpleado: Int64?
    var fechaCobro: Date?
    var fechaPago: Date?
    var importe: Double?
    var estatusOrden: Int64?
    var comentarios: String?
    var idDireccionCobro: Int64?
    var comentariosReprogramacion: String?

    init(idOrden: Int64,
         idDonante: Int64,
         idEmpleado: Int64?,
         fechaCobro: String?,
         fechaPago: String?,
         importe: Double?,
         estatusOrden: Int64?,
         comentarios: String?,
         idDireccionCobro: Int64?,
         comentariosReprogramacion: String?) {

        self.idOrden = idOrden
        self.idDonante = idDonante
        self.idEmpleado = idEmpleado
        self.importe = importe
        self.estatusOrden = estatusOrden
        self.comentarios = comentarios
        self.idDireccionCobro = idDireccionCobro
        self.comentariosReprogramacion = comentariosReprogramacion

        // DateFormatter para convertir las cadenas de fecha de SQL Server a Date de Swift
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // SQL Server 'date' no tiene zona horaria

        if let fechaCobroStr = fechaCobro {
            self.fechaCobro = dateFormatter.date(from: fechaCobroStr)
        } else {
            self.fechaCobro = nil
        }

        if let fechaPagoStr = fechaPago {
            self.fechaPago = dateFormatter.date(from: fechaPagoStr)
        } else {
            self.fechaPago = nil
        }
    }
}

// Estructura para manejar la respuesta del JSON

func fetchOrdenes(forEmpleado idEmpleado: Int64, completion: @escaping ([Orden]?) -> Void) {
    let url = URL(string: "http://10.22.132.114:8037/ordenes/\(idEmpleado)")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("Error en la solicitud: \(error?.localizedDescription ?? "Unknown error")")
            completion(nil)
            return
        }

        do {
            // Decodificar la respuesta
            let decoder = JSONDecoder()
            // Configurar el formato de fecha
            decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
            // Decodificar la lista de ordenes
            let ordenesResponse = try decoder.decode(OrdenesResponse.self, from: data)
            completion(ordenesResponse.list)
        } catch {
            print("Error en la decodificación: \(error.localizedDescription)")
            completion(nil)
        }
    }

    task.resume()
}

struct OrdenesResponse: Decodable {
    let mensaje: String
    let list: [Orden]
}


// Extension para formatear fechas
extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
}

fetchOrdenes(forEmpleado: 123) { ordenes in
    if let ordenes = ordenes {
        // Aquí tienes la lista de ordenes
        print(ordenes)
    } else {
        print("No se pudo obtener las ordenes.")
    }
}




