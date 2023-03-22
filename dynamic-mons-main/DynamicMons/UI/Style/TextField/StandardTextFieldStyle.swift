//
//  StandardTextFieldStyle.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import SwiftUI

struct StandardTextFieldStyle: TextFieldStyle {
    let icon: Image?

    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: CornerRadius.large)
                .fill(AppColor.main.customBackground)
                .frame(height: 52)
            HStack {
                icon
                configuration
            }
            .padding(.leading)
            .foregroundColor(AppColor.main.placeholder)
            .appFont(.large)
        }
    }
}

extension TextFieldStyle where Self == StandardTextFieldStyle {
    static func standard(withIcon icon: Image? = nil) -> StandardTextFieldStyle {
        return .init(icon: icon)
    }
}
