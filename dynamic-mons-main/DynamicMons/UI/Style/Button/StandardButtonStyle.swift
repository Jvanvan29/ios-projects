//
//  StandardButtonStyle.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import SwiftUI

struct StandardButtonStyle: ButtonStyle {
    enum Kind: Equatable {
        case primary
        case secondary
        case custom(color: Color)
    }

    private static let pressedOpacity: CGFloat = 0.5

    let kind: Kind

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(Spacing.main.extraSmall)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .foregroundColor(foregroundColor(isPressed: configuration.isPressed))
            .background(RoundedRectangle(cornerRadius: CornerRadius.large).fill(backgroundColor(isPressed: configuration.isPressed)))
            .appFont(.largeMedium)
    }

    private func foregroundColor(isPressed: Bool) -> Color {
        switch kind {
        case .primary:
            return AppColor.main.light
        case .secondary:
            let color = AppColor.main.tint
            return isPressed ? color.opacity(Self.pressedOpacity) : color
        case .custom:
            return AppColor.main.light
        }
    }

    private func backgroundColor(isPressed: Bool) -> Color {
        let color: Color
        switch kind {
        case .primary:
            color = AppColor.main.tint
        case .secondary:
            color = AppColor.main.light
        case .custom(let customColor):
            color = customColor
        }
        return isPressed ? color.opacity(Self.pressedOpacity) : color
    }
}

extension ButtonStyle where Self == StandardButtonStyle {
    static func standard(ofKind kind: StandardButtonStyle.Kind) -> StandardButtonStyle {
        return .init(kind: kind)
    }
}
