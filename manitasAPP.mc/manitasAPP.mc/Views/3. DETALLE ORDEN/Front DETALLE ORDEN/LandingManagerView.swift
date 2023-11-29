//
//  LandingManagerView.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 10/11/23.
//

import SwiftUI

var estado0Count: Int?
var estado1Count: Int?
var estado2Count: Int?

var estado0Sum: Double?
var estado1Sum: Double?
var estado2Sum: Double?



struct OrderCountResponse: Codable {
    let mensaje: String
    let conteo: CountDetails
    let suma: SumDetails
}

struct CountDetails: Codable {
    let Estado0: Int?
    let Estado1: Int?
    let Estado2: Int?
}

struct SumDetails: Codable {
    let Estado0: Double?
    let Estado1: Double?
    let Estado2: Double?
}


struct LandingManagerView: View {
    @State var idRepartidor = 2
    @State private var isActive = false
    @Environment(\.dismiss) var dismiss
    @State private var listaOrdenes: [Orden] = []
    @State private var ordenesPendientes: [Orden] = []
    @State private var ordenesRecolectadas: [Orden] = []
    @State private var ordenesNoRecolectadas: [Orden] = []
    @State private var isLoading = true
    @State private var isView1Active = true
    @State private var toggleText = ""
    @State private var toggleIcon = "star"
    @State var Dinerototals=0.0
    @State var Dinerorecolectado=0.0
    @State var Recibostotales=1.0
    @State var RecibosCompletados=0.0
    // Función para verificar si se han cargado los datos
    private func checkLoadingState() {
        if !ordenesPendientes.isEmpty {
            isLoading = false
        }
    }

    let timer=Timer.publish(every: 10, on: .current, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack(){
            HStack {
                Button("← Regresar") {
                    dismiss()
                }
                Spacer()
            } .padding(.horizontal, 20)
            VStack(){
                VStack(){
                    NavigationLink(destination: (ProfileView())){
                        ProfileManagerView()
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                    .navigationBarBackButtonHidden(false)
                }
                NavigationView{
                    VStack{
                        VStack{
                            if isView1Active {
                                
                                View1(totales: Recibostotales, completados: RecibosCompletados)
                                
                                //toggleIcon = "arrow.right.circle.fill"
                            } else {
                                View2(total: Dinerototals, recolectado: Dinerorecolectado)
                                //toggleIcon = "arrow.backward.circle.fill"
                                
                            }
                        }
                        Spacer()
                        HStack{
                            HStack{Spacer()}
                            Button(action: {
                                // Toggle between views
                                isView1Active.toggle()
                            }) {
                                Image(systemName: toggleIcon)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color("manitasAzul"))
                            }
                            HStack{Spacer()}
                        }
                    }
                }
                .frame(height:150)
                
                if ordenesPendientes.isEmpty{
                    VStack {
                        Spacer()
                        ProgressView()
                            .scaleEffect(3)
                            .padding(.bottom, 30)
                        Text("Cargando recibos . . .")
                            .font(.system(size: 30))
                            .foregroundColor(.blue)
                        Spacer()
                    }
                } else {
                    List {
                        Section(header: Text("Pendientes")) {
                            ForEach(ordenesPendientes, id: \.idOrden) { orden in
                                NavigationLink(destination: DetalleOrdenView(orden: orden)
                                    // ERROR: DetalleOrdenManagerView
                                    .navigationBarBackButtonHidden(true)
                                ) {
                                    OrdenBarView(orden: orden)
                                }
                                
                            }
                        }
                        Section(header: Text("Recolectadas")) {
                            if ordenesRecolectadas.isEmpty{
                                HStack{
                                    Spacer()
                                    Image(systemName: "tray.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.gray)
                                        .padding()
                                    
                                    Text("No Hay Recibos Recolectados")
                                        .font(.title)
                                        .fontWeight(.regular)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                            }else{
                                ForEach(ordenesRecolectadas, id: \.idOrden) { orden in
                                    NavigationLink(destination: DetalleOrdenView(orden: orden)
                                        // ERROR: DetalleOrdenManagerView
                                        .navigationBarBackButtonHidden(true)
                                    ) {
                                        OrdenBarView(orden: orden)
                                    }
                                }
                            }
                        }
                        
                        Section(header: Text("No Recolectadas")) {
                            if ordenesNoRecolectadas.isEmpty{
                                HStack{
                                    Spacer()
                                    Image(systemName: "tray.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.gray)
                                        .padding()
                                    
                                    Text("No Hay Recibos No Recolectados")
                                        .font(.title)
                                        .fontWeight(.regular)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                            }else{
                                ForEach(ordenesNoRecolectadas, id: \.idOrden) { orden in
                                    NavigationLink(destination: DetalleOrdenView(orden: orden)
                                        // ERROR: DetalleOrdenManagerView
                                        .navigationBarBackButtonHidden(true)
                                    ) {
                                        OrdenBarView(orden: orden)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                fetchOrderCountForEmployee(employeeID: idRepartidor) { result in
                   switch result {
                   case .success(let response):
                       print("Mensaje: \(response.mensaje)")
                       if let countZero = response.conteo.Estado0 , let countOne = response.conteo.Estado1, let sumaZero = response.suma.Estado0, let sumaOne = response.suma.Estado1{
                           Recibostotales = Double(countZero + countOne)
                           RecibosCompletados = Double(countOne)
                           Dinerototals = Double(sumaOne) + Double(sumaZero)
                           Dinerorecolectado = Double(sumaOne)
                 
                           
                           
                       } else {
                           print("Conteo Estado0 y Estado1 no estan disponibles")
                       }
                       // ... imprimir otros valores o realizar otras acciones ...
                       
                       
                   case .failure(let error):
                       print("Error: \(error.localizedDescription)")
                   }
               }
                
                // Ejecuta todas las solicitudes de carga de datos
                fetchOrders(forEmployeeID: idRepartidor, forEstatusId: 0) { ordenes in
                    self.ordenesPendientes = ordenes
                    checkLoadingState()
                }
                fetchOrders(forEmployeeID: idRepartidor, forEstatusId: 1) { ordenes in
                    self.ordenesRecolectadas = ordenes
                    checkLoadingState()
                }
                fetchOrders(forEmployeeID: idRepartidor, forEstatusId: 2) { ordenes in
                    self.ordenesNoRecolectadas = ordenes
                    checkLoadingState()
                }
            }
            .onReceive(timer){ _ in
                fetchOrderCountForEmployee(employeeID: idRepartidor) { result in
                   switch result {
                   case .success(let response):
                       print("Mensaje: \(response.mensaje)")
                       if let countZero = response.conteo.Estado0 , let countOne = response.conteo.Estado1, let sumaZero = response.suma.Estado0, let sumaOne = response.suma.Estado1{
                           Recibostotales = Double(countZero + countOne)
                           RecibosCompletados = Double(countOne)
                           print(Recibostotales)
                           print("--------------------------------")
                           Dinerototals = Double(sumaOne) + Double(sumaZero)
                           Dinerorecolectado = Double(sumaOne)

                       } else {
                           print("Conteo Estado0 y Estado1 no estan disponibles")
                       }
                       // ... imprimir otros valores o realizar otras acciones ...
                       
                       
                   case .failure(let error):
                       print("Error: \(error.localizedDescription)")
                   }
               }
                // Ejecuta todas las solicitudes de carga de datos
                fetchOrders(forEmployeeID: idRepartidor, forEstatusId: 0) { ordenes in
                    self.ordenesPendientes = ordenes
                    checkLoadingState()
                }
                fetchOrders(forEmployeeID: idRepartidor, forEstatusId: 1) { ordenes in
                    self.ordenesRecolectadas = ordenes
                    checkLoadingState()
                }
                fetchOrders(forEmployeeID: idRepartidor, forEstatusId: 2) { ordenes in
                    self.ordenesNoRecolectadas = ordenes
                    checkLoadingState()
                }
            }
        }
    }
}

struct LandingManagerView_Previews: PreviewProvider {
    static var previews: some View {
        LandingManagerView()
    }
}

// Función para obtener el conteo y la suma de órdenes
func fetchOrderCountForEmployee(employeeID: Int, completion: @escaping (Result<OrderCountResponse, Error>) -> Void) {
    // Construcción de la URL
    let urlString = "\(apiUrl)/conteo_ordenes/\(employeeID)"
    guard let url = URL(string: urlString) else {
        completion(.failure(URLError(.badURL)))
        return
    }

    // Iniciar la tarea de red
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(URLError(.badServerResponse)))
            return
        }

        do {
            let decodedResponse = try JSONDecoder().decode(OrderCountResponse.self, from: data)

            // Asignar el valor a la variable externa
            estado0Count = decodedResponse.conteo.Estado0
            estado1Count = decodedResponse.conteo.Estado1
            estado2Count = decodedResponse.conteo.Estado2

            estado0Sum = decodedResponse.suma.Estado0
            estado1Sum = decodedResponse.suma.Estado1
            estado2Sum = decodedResponse.suma.Estado2

            // Llamar al closure de completion con la respuesta
            completion(.success(decodedResponse))
        } catch {
            completion(.failure(error))
        }
    }
    task.resume()
}

