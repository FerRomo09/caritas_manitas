//
//  ModelData.swift
//  ProbarAPIRomo
//
//  Created by Romo
//

import Foundation

struct Donante:Codable, Identifiable{
    var ID_DONANTES: Int
    var A_PATERNO: String
    var A_MATERNO: String
    var NOMBRE: String
    var FECHA_NAC: String
    var EMAIL: String
    var TEL_CASA: Int
    var TEL_OFICINA: Int
    var TEL_MOVIL: Int
    var ULTIMO_DONATIVO: Int
    var ID_GENERO: Int
    var id: Int {
        return self.ID_DONANTES
    }
}

struct Empleado:Codable, Identifiable{ // Protocolo para convertir del JSON  a estructura de datos automáticamente, Identifiable para hacer una lista
    var ID_EMPLEADO: Int
    var A_PATERNO: String
    var A_MATERNO: String
    var NOMBRE: String
    var FECHA_NAC: String
    var EMAIL: String
    var TEL_MOVIL: Int
    var ID_GENERO: Int
    var ROL: Bool
    var id: Int {
        return self.ID_EMPLEADO
    }
}

struct Recibo:Codable, Identifiable{
    var ID_RECIBO: Int
    var ID_DONANTES: Int
    var ID_EMPLEADO: Int
    var FECHA_COBRO: String
    var FECHA_PAGO: String
    var FECHA_VISITA: String
    var IMPORTE: Double
    /*
    var TEL_CASA: Int
    var TEL_OFICINA: Int
    var TEL_MOVIL: Int
    var ULTIMO_DONATIVO: Int
    var ID_GENERO: Int
     */
    var id: Int {
        return self.ID_RECIBO
    }
}

