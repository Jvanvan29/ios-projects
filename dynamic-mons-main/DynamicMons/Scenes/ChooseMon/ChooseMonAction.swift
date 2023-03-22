//
//  ChooseMonAction.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import Foundation

enum ChooseMonAction: Equatable {
    case fetchData
    case fetchDataResponse(Result<[StarterMon], NetworkError>)
    case setSelectedMon(index: Int)
    case chooseMon
    case saveSelectedMon(Result<Mon, GenericError>)
}
