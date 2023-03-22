//
//  ChooseMonReducer.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import ComposableArchitecture

let chooseMonReducer = AnyReducer<ChooseMonState, ChooseMonAction, ChooseMonEnvironment> { state, action, environment in
    switch action {
    case .fetchData:
        let request = FetchStarterMonsDataRequest()
        return environment.networkClient.execute(request: request)
            .receive(on: environment.mainQueue)
            .eraseToEffect()
            .catchToEffect(ChooseMonAction.fetchDataResponse)
    case let .fetchDataResponse(.success(mons)):
        state.starterMons = mons.map(\.mon)
        return .none
    case .setSelectedMon(let index):
        state.selectedMonIndex = index
        return .none
    case .chooseMon:
        guard var mon = state.selectedMon else {
            return .none
        }
        return environment.localDatabase.createTable(ofType: Mon.self)
            .flatMap { environment.localDatabase.write(value: mon) }
            .receive(on: environment.mainQueue)
            .eraseToEffect()
            .catchToEffect(ChooseMonAction.saveSelectedMon)
    default:
        return .none
    }
}
    .debug()
