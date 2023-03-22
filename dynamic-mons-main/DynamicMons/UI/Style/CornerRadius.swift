//
//  CornerRadius.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import SwiftUI

struct CornerRadius: Equatable {
    var radius: CGFloat
    var corners: UIRectCorner

    init(radius: CGFloat, corners: UIRectCorner = .allCorners) {
        (self.radius, self.corners) = (radius, corners)
    }

    init(top radius: CGFloat) {
        (self.radius, self.corners) = (radius, [ .topLeft, .topRight ])
    }

    init(bottom radius: CGFloat) {
        (self.radius, self.corners) = (radius, [ .bottomLeft, .bottomRight ])
    }
}

extension CornerRadius {
    /// The default corner radius, at 8pt.
    static let `default`: CGFloat = 8
    /// The medium corner radius, at 12pt.
    static let medium: CGFloat = 12
    /// The large corner radius, at 16pt.
    static let large: CGFloat = 16
    /// The large corner radius, at 16pt.
    static let card: CGFloat = 32
}
