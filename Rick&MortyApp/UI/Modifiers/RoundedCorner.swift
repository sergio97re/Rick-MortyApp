//
//  RoundedCorner.swift
//  Rick&MortyApp
//
//  Created by Sergio Reina Montes on 30/04/2025.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = 10.0
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


#Preview {
    RoundedCorner()
}
