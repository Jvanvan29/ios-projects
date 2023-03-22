//
//  HomeState.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import ComposableArchitecture
import SwiftUI

struct HomeState: Equatable {
    var mons: [Mon]

    var selectedMon: Mon?
}
