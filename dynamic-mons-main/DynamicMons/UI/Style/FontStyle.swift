//
//  FontStyle.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import SwiftUI

enum FontStyle {
    /// 14pt, regular.
    case regular
    /// 14pt, medium.
    case regularMedium
    /// 16pt, regular.
    case large
    /// 16pt, medium.
    case largeMedium
    /// 18pt, regular.
    case veryLarge
    /// 18pt, medium.
    case veryLargeMedium
    /// 20pt, regular.
    case subtitle
    /// 22pt, medium.
    case title
    /// 24pt, bold.
    case titleLarge
    /// 27pt, bold.
    case titleVeryLarge
    /// 32pt, bold.
    case titleExtraLarge

    var size: CGFloat {
        switch self {
        case .regular:
            return 14
        case .regularMedium:
            return 14
        case .large:
            return 16
        case .largeMedium:
            return 16
        case .veryLarge:
            return 18
        case .veryLargeMedium:
            return 18
        case .subtitle:
            return 20
        case .title:
            return 22
        case .titleLarge:
            return 24
        case .titleVeryLarge:
            return 27
        case .titleExtraLarge:
            return 32
        }
    }

    var color: Color {
        switch self {
        case .regularMedium, .large, .largeMedium, .title, .titleLarge, .titleVeryLarge, .titleExtraLarge:
            return AppColor.main.font
        default:
            return AppColor.main.placeholder
        }
    }
}
