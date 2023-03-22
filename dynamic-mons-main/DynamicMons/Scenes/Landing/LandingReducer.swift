//
//  LandingReducer.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import ComposableArchitecture

let landingReducer = AnyReducer<LandingState, LandingAction, LandingEnvironment> { state, action, environment in
    switch action {
    case .fetchData:
        return environment.localDatabase.fetchAll(type: Mon.self)
            .receive(on: environment.mainQueue)
            .eraseToEffect()
            .catchToEffect(LandingAction.fetchDataResponse)
    default:
        return .none
    }
}
    .debug()
