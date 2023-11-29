//
//  DineroProgressBarView.swift
//  manitasAPP.mc
//
//  Created by Alumno on 28/11/23.
//

import SwiftUI

struct DineroProgressBarView: View {
    @State var dineroTotal: Double = 12000
    @State var dineroRecolectado: Double = 5400
    var body: some View {
        VStack(){
            let porcentaje = (dineroRecolectado / dineroTotal) * 100.0
            let dineroFaltante = dineroTotal - dineroRecolectado
           

            VStack(alignment: .leading){
                HStack{Spacer()}
                Text("Total a Recolectar: ")
                    .font(.system(size: 21))
                    .fontWeight(.bold)
                    .foregroundColor(Color("manitasNegro"))
                + Text("\(FormatearNumero(numeroBase: dineroTotal))") //REEMPLAZAR POR VARIABLES
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
    }
    func FormatearNumero(numeroBase: Double?) -> String {
        var numeroStr: String = ""
        var numeroBaseSimple = 0.0
        let formatoNumero = NumberFormatter()

        formatoNumero.numberStyle = .currency

        if let numeroBase = numeroBase {
            numeroBaseSimple = numeroBase
        } else {
            numeroBaseSimple = 0.0
        }

        if let formattedNumber = formatoNumero.string(from: NSNumber(value: numeroBaseSimple)) {
            numeroStr = formattedNumber
        }

        return numeroStr
    }
}

struct DineroProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        DineroProgressBarView()
    }
}
