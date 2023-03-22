//
//  ChooseMonState.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import ComposableArchitecture
import SwiftUI

struct ChooseMonState: Equatable {
    var starterMons = [Mon]()
    var selectedMonIndex: Int = 0

    var selectedMon: Mon? {
        return starterMons[safe: selectedMonIndex]
    }
}
