//
//  AppReducer.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import ComposableArchitecture

let appReducer = AnyReducer<AppState, AppAction, AppEnvironment>.combine(
    landingReducer
        .pullback(
            state: /AppState.landing,
            action: /AppAction.landing,
            environment: {
                LandingEnvironment(
                    localDatabase: $0.localDatabase,
                    mainQueue: $0.mainQueue
                )
            }
        ),
    chooseMonReducer
        .pullback(
            state: /AppState.chooseMon,
            action: /AppAction.chooseMon,
            environment: {
                ChooseMonEnvironment(
                    localDatabase: $0.localDatabase,
                    networkClient: $0.networkClient,
                    persistenceManager: $0.persistenceManager,
                    mainQueue: $0.mainQueue
                )
            }
        ),
    homeReducer
        .pullback(
            state: /AppState.home,
            action: /AppAction.home,
            environment: {
                HomeEnvironment(
                    healthManager: $0.healthManager,
                    imageCacheManager: $0.imageCacheManager,
                    localDatabase: $0.localDatabase,
                    persistenceManager: $0.persistenceManager,
                    mainQueue: $0.mainQueue
                )
            }
        ),
    AnyReducer { state, action, environment in
        switch action {
        case let .landing(.fetchDataResponse(.success(mons))):
            if mons.isEmpty {
                state = .chooseMon(ChooseMonState())
            } else {
                state = .home(HomeState(mons: mons))
            }
            return .none
        case let .chooseMon(.saveSelectedMon(.success(mon))):
            state = .home(HomeState(mons: [mon]))
            return .none
        default:
            return .none
        }
    }
)
    .debug()
