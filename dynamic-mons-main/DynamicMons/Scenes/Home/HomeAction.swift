//
//  HomeAction.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import Foundation

enum HomeAction: Equatable {
    case fetchData
    case updateBurnedEnergy(amount: Double?)
    case updateMonExperience(Result<Mon, GenericError>)
    case setSelectedMon(Mon)
}
