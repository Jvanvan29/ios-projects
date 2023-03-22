//
//  Spacing.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import UIKit

struct Spacing {
    static var main = Spacing()

    /// 8pt.
    let extraSmall: CGFloat
    /// 12pt.
    let small: CGFloat
    /// 16pt.
    let regular: CGFloat
    /// 20pt.
    let large: CGFloat
    /// 24pt.
    let veryLarge: CGFloat
    /// 28pt.
    let extraLarge: CGFloat

    init(
        extraSmall: CGFloat = 8,
        small: CGFloat = 12,
        regular: CGFloat = 16,
        large: CGFloat = 20,
        veryLarge: CGFloat = 24,
        extraLarge: CGFloat = 28
    ) {
        self.extraSmall = extraSmall
        self.small = small
        self.regular = regular
        self.large = large
        self.veryLarge = veryLarge
        self.extraLarge = extraLarge
    }
}
