//
//  AppColor.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import SwiftUI

struct AppColor {
    static var main = AppColor()

    let card: Color
    let customBackground: Color
    let dark: Color
    let error: Color
    let font: Color
    let light: Color
    let placeholder: Color
    let tint: Color

    init(
        card: Color = Color(r: 209, g: 212, b: 217),
        customBackground: Color = Color(r: 237, g: 240, b: 244),
        dark: Color = .black,
        error: Color = .red,
        font: Color = .black,
        light: Color = .white,
        placeholder: Color = .gray,
        tint: Color = .blue
    ) {
        self.card = card
        self.customBackground = customBackground
        self.dark = dark
        self.error = error
        self.font = font
        self.light = light
        self.placeholder = placeholder
        self.tint = tint
    }
}
