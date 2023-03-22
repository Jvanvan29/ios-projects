//
//  MonBallView.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import SwiftUI

struct MonBallView: View {
    @Binding var isSelected: Bool

    var body: some View {
        Button(
            action: {
                $isSelected.wrappedValue.toggle()
            }
        ) {
            Image("poke-ball")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(isSelected ? 1 : 0.7)
                .rotationEffect(isSelected ? Angle(degrees: -15) : Angle(degrees: 18))
        }
    }

    init(isSelected: Binding<Bool>) {
        self._isSelected = isSelected
    }
}
