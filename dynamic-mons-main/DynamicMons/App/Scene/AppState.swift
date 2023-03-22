//
//  AppState.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import Foundation

enum AppState: Equatable {
    case landing(LandingState)
    case chooseMon(ChooseMonState)
    case home(HomeState)
}
