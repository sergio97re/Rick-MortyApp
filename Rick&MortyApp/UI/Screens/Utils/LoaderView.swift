//
//  LoaderView.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 24/03/2025.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "clock.fill")
                .resizable()
                .frame(width: 100, height: 100)
            
            Text("Cargando datos ...")
                .font(.title)
        }
    }
}

#Preview {
    LoaderView()
}
