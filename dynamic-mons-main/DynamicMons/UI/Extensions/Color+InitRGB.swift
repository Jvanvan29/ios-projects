//
//  Color+InitRGB.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import SwiftUI

extension Color {
    init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255))
    }
}
