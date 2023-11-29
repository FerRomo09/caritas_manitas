//
//  LandingManagerView.swift
//  manitasAPP.mc
//
//  Created by Jacobo Hirsch on 10/11/23.
//

import SwiftUI

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

    // Función para verificar si se han cargado los datos
    private func checkLoadingState() {
        if !ordenesPendientes.isEmpty {
            isLoading = false
        }
    }

    let timer=Timer.publish(every: 100, on: .current, in: .common).autoconnect()
    
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
                            var total:Double=listaOrdenes.reduce(0.0) result, orden in
                                result + orden.importe
                            }
                            var recolectado: Double=ordenesRecolectadas.reduce(0.0) result, orden in
                                result + orden.importe
                            }
                            
                            ForEach(ordenesPendientes, id: \.idOrden) { orden in
                                
                            }
                            
                            if isView1Active {
                                View1(totales: Double(listaOrdenes.count), completados: Double(ordenesRecolectadas.count-listaOrdenes.count))
                                //toggleIcon = "arrow.right.circle.fill"
                            } else {
                                View2(total: total, recolectado: recolectado)
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
