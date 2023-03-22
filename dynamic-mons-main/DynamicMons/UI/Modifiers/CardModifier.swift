//
//  CardModifier.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(CornerRadius.card)
            .shadow(color: AppColor.main.card, radius: 10, x: 0, y: 0)
    }

}
