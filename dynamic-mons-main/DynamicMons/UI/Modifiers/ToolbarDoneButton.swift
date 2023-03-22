//
//  ToolbarDoneButton.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import SwiftUI

struct ToolbarDoneButton: ViewModifier {
    let action: (() -> Void)?

    func body(content: Content) -> some View {
        return content
            .toolbar {
                Button("Done") { action?() }
                .foregroundColor(AppColor.main.tint)
                .appFont(.largeMedium)
            }
    }
}

extension View {
    func toolbarDoneButton(action: (() -> Void)? = nil) -> some View {
        self.modifier(ToolbarDoneButton(action: action))
    }
}
