//
//  AppAction.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import Foundation

enum AppAction: Equatable {
    case landing(LandingAction)
    case chooseMon(ChooseMonAction)
    case home(HomeAction)
}
