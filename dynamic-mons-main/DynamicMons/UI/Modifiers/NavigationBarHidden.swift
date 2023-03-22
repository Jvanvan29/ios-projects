//
//  NavigationBarHidden.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import SwiftUI

struct NavigationBarHidden: ViewModifier {
    let title: String
    let titleDisplayMode: NavigationBarItem.TitleDisplayMode
    let isHidden: Bool

    func body(content: Content) -> some View {
        return content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(titleDisplayMode)
            .navigationBarHidden(isHidden)
            .navigationBarBackButtonHidden(isHidden)
    }
}

extension View {
    func navigationBar(isHidden: Bool, title: String = "", titleDisplayMode: NavigationBarItem.TitleDisplayMode = .inline) -> some View {
        let title = isHidden ? "" : title
        return self.modifier(NavigationBarHidden(title: title, titleDisplayMode: titleDisplayMode, isHidden: isHidden))
    }
}
