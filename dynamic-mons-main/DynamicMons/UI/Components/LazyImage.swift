//
//  MonBallView.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import NukeUI
import SwiftUI

struct LazyImage: View {
    private let url: URL

    var body: some View {
        NukeUI.LazyImage(url: url)
    }

    init(url: URL) {
        self.url = url
    }
}
