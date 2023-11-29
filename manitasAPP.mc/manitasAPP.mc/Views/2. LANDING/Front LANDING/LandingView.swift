//
//  LandingView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI
import Foundation


struct LandingView: View {
    @State private var listaOrdenes: [Orden] = []
    @State private var ordenesPendientes: [Orden] = []
    @State private var ordenesRecolectadas: [Orden] = []
    @State private var ordenesNoRecolectadas: [Orden] = []
    @State private var isLoading = true
    @State private var isView1Active = true
    @State private var toggleText = ""
    @State private var toggleIcon = "star"
    @State private var idRepartidor=curretUser.ID
    
    // Función para verificar si se han cargado los datos
    private func checkLoadingState() {
        if !ordenesPendientes.isEmpty {
            isLoading = false
        }
    }

    let timer=Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack(){
            VStack(){
                VStack(){
                    NavigationLink(destination: (ProfileView()
                        .navigationBarBackButtonHidden(true))){
                        ProfileBarView()
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                    .navigationBarBackButtonHidden(true)
                }
                NavigationView{
                    VStack{
                        VStack{
                            VStack(){
                                let porcentaje = (RecibosCompletados / RecibosTotales) * 100.0
                                let recibosFaltantes = RecibosTotales - RecibosCompletados

                                VStack(alignment: .leading){
                                    HStack{Spacer()}
                                    Text("Recibos del Día: ")
                                        .font(.system(size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("manitasNegro"))
                                    + Text("\(String(format: "%.0f", RecibosTotales))") //REEMPLAZAR POR VARIABLES
                                        .font(.system(size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("manitasAzul"))
                                }
                                .padding(.horizontal, 40)
                                ProgressView(value: porcentaje, total: 100) //Remplazar con formula para calcular el porcentaje
                                    .padding(.horizontal, 40) //Remplazar
                                    .tint(Color("manitasAzul"))
                                Text("Recibos Faltantes: ")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color("manitasNegro"))
                                + Text("\(String(format: "%.0f", recibosFaltantes))") //REEMPLAZAR POR VARIABLE ENTERA
                                    .font(.system(size: 15))
                                    .foregroundColor(Color("manitasAzul"))
                            }
                        }
                        VStack(){
                            let porcentaje = (Dinerorecolectado / Dinerototals) * 100.0
                            let dineroFaltante = Dinerototals - Dinerorecolectado
                           

                            VStack(alignment: .leading){
                                HStack{Spacer()}
                                Text("Total a Recolectar: ")
                                    .font(.system(size: 21))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("manitasNegro"))
                                + Text("\(FormatearNumero(numeroBase: Dinerototals))") //REEMPLAZAR POR VARIABLES
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("manitasMorado"))
                            }
                            .padding(.horizontal, 40)
                            ProgressView(value: porcentaje, total: 100) //Remplazar con formula para calcular el porcentaje
                                .padding(.horizontal, 40) //Remplazar
                                .tint(Color("manitasMorado"))
                            Text("Donativo Faltante: ")
                                .font(.system(size: 15))
                                .foregroundColor(Color("manitasNegro"))
                            + Text("\(FormatearNumero(numeroBase: dineroFaltante))") //REEMPLAZAR POR VARIABLE ENTERA
                                .font(.system(size: 15))
                                .foregroundColor(Color("manitasMorado"))
                        }
                        Spacer()
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
                                    
                                    Text("No hay recolectados")
                                        .font(.title)
                                        .fontWeight(.regular)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                            }else{
                                ForEach(ordenesRecolectadas, id: \.idOrden) { orden in
                                    NavigationLink(destination: DetalleOrdenView(orden: orden)
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
                                    
                                    Text("No hay recolectados")
                                        .font(.title)
                                        .fontWeight(.regular)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                            }else{
                                ForEach(ordenesNoRecolectadas, id: \.idOrden) { orden in
                                    NavigationLink(destination: DetalleOrdenView(orden: orden)
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
                           RecibosTotales = Double(countZero + countOne)
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
                           RecibosTotales = Double(countZero + countOne)
                           RecibosCompletados = Double(countOne)
                           print(RecibosTotales)
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

struct View1: View {
    var totales:Double
    var completados:Double
    var body: some View {
        ProgressBarView(recibosTotales: totales, recibosCompletados: completados)
    }
}
struct View2: View {
    var total=0.0
    var recolectado=0.0
    var body: some View {
        DineroProgressBarView(dineroTotal: total, dineroRecolectado: recolectado)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}

