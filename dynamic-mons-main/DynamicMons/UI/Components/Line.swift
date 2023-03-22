//
//  Line.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import SwiftUI

struct Line: View {
    let color: Color

    var body: some View {
        VStack {
            Divider()
            .background(color)
        }
    }

    init(color: Color = AppColor.main.customBackground) {
        self.color = color
    }
}
