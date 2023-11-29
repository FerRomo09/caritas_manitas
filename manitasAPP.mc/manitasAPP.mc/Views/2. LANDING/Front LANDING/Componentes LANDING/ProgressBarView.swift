//
//  ProgressBarView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 28/11/23.
//

import SwiftUI

struct ProgressBarView: View {
    @State private var recibosTotales: Double = 12
    @State private var recibosCompletados: Double = 5
    var body: some View {
        //Stack ordenes del dia
        VStack(){
            let porcentaje = (recibosCompletados / recibosTotales) * 100.0
            let recibosFaltantes = recibosTotales - recibosCompletados

            VStack(alignment: .leading){
                HStack{Spacer()}
                Text("Recibos del Día: ")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(Color("manitasNegro"))
                + Text("\(String(format: "%.0f", recibosTotales))") //REEMPLAZAR POR VARIABLES
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
}


struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
    }
}
