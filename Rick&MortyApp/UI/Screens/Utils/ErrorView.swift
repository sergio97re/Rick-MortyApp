//
//  ErrorView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 27/03/2025.
//

import SwiftUI

struct ErrorView: View {
    @Environment(RootViewModel.self) private var rootViewModel
    
    private var textError: String
    
    init(error: String) {
        self.textError = error
    }
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundStyle(.red)
            
            Text("Error al cargar datos: \(textError)")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.red)
            
            Button {
                //Accion de reintentar
            } label: {
                Text("Reintentar carga")
                    .frame(width: 150, height: 40)
                    .background(Color.yellow)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

        }
    }
}

#Preview {
    ErrorView(error: "Prueba de error")
        .environment(RootViewModel())
}
