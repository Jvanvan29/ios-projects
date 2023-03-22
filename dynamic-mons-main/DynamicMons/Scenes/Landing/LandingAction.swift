//
//  LandingAction.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import Foundation

enum LandingAction: Equatable {
    case fetchData
    case fetchDataResponse(Result<[Mon], GenericError>)
}
