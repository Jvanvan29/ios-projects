//
//  AppFont.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import SwiftUI

struct AppFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory

    let style: FontStyle
    let customColor: Color?

    init(style: FontStyle, customColor: Color?) {
        self.style = style
        self.customColor = customColor
    }

    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: style.size)
        return content
            .font(font(ofSize: scaledSize))
            .foregroundColor(customColor ?? style.color)
    }

    private func font(ofSize size: CGFloat) -> Font {
        switch style {
        case .regular:
            return font(ofSize: size, weight: .regular)
        case .regularMedium:
            return font(ofSize: size, weight: .medium)
        case .large:
            return font(ofSize: size, weight: .regular)
        case .largeMedium:
            return font(ofSize: size, weight: .medium)
        case .veryLarge:
            return font(ofSize: size, weight: .regular)
        case .veryLargeMedium:
            return font(ofSize: size, weight: .medium)
        case .subtitle:
            return font(ofSize: size, weight: .medium)
        case .title:
            return font(ofSize: size, weight: .medium)
        case .titleLarge:
            return font(ofSize: size, weight: .bold)
        case .titleVeryLarge:
            return font(ofSize: size, weight: .bold)
        case .titleExtraLarge:
            return font(ofSize: size, weight: .bold)
        }
    }

    private func font(ofSize size: CGFloat, weight: Font.Weight) -> Font {
        let name = "HelveticaNeue"
        switch weight {
        case .bold:
            return .custom("\(name)-Bold", size: size)
        case .light:
            return .custom("\(name)-Light", size: size)
        case .medium:
            return .custom("\(name)-Medium", size: size)
        default:
            return .custom("\(name)", size: size)
        }
    }
}

extension View {
    func appFont(_ style: FontStyle, customColor: Color? = nil) -> some View {
        self.modifier(AppFont(style: style, customColor: customColor))
    }
}
