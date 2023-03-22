//
//  HomeReducer.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import ActivityKit
import Combine
import ComposableArchitecture
import Foundation
import WidgetKit

let homeReducer = AnyReducer<HomeState, HomeAction, HomeEnvironment> { state, action, environment in
    switch action {
    case .fetchData:
        setUpSelectedMon()
        return .task { [state] in
            await setUpDynamicIsland(sprite: state.selectedMon?.sprite)
            let amount = try? await environment.healthManager.getBurnedEnergy()
            return .updateBurnedEnergy(amount: amount)
        }
    case .updateBurnedEnergy(let amount):
        guard let amount = amount else {
            return .none
        }
        let lastBurnedEnergyKey = PersistenceKey.lastBurnedEnergy.rawValue
        let currentBurnedEnergy: BurnedEnergy? = environment.persistenceManager.retrieve(lastBurnedEnergyKey, storageType: .sensitive)
        let burnedEnergy = BurnedEnergy(date: Date(), amount: amount)
        environment.persistenceManager.persist(burnedEnergy, key: lastBurnedEnergyKey, storageType: .sensitive)
        if var selectedMon = state.selectedMon,
           let currentBurnedEnergy = currentBurnedEnergy,
           let distance = burnedEnergy.date.fullDistance(from: currentBurnedEnergy.date, resultIn: .day) {
            var amountToAdd = burnedEnergy.amount
            if distance == 0 {
                amountToAdd -= currentBurnedEnergy.amount
            }
            selectedMon.experience += amountToAdd
            return environment.localDatabase.write(value: selectedMon)
                .receive(on: environment.mainQueue)
                .eraseToEffect()
                .catchToEffect(HomeAction.updateMonExperience)
        }
        return .none
    case let .updateMonExperience(.success(mon)):
        state.selectedMon = mon
        return .none
    case .setSelectedMon(let mon):
        setSelectedMon(mon)
        return .none
    default:
        return .none
    }

    func setUpSelectedMon() {
        if let id: Int64? = environment.persistenceManager.retrieve(PersistenceKey.selectedMonID.rawValue, storageType: .userDefaults) {
            let mon = state.mons.first(where: { $0.id == id })
            setSelectedMon(mon)
        } else {
            let mon = state.mons[safe: 0]
            setSelectedMon(mon)
        }
    }

    func setSelectedMon(_ mon: Mon?) {
        state.selectedMon = state.mons.first(where: { $0.id == mon?.id })
        environment.persistenceManager.persist(state.selectedMon?.id, key: PersistenceKey.selectedMonID.rawValue, storageType: .userDefaults)
    }

    @Sendable func setUpDynamicIsland(sprite: URL?) async {
        guard let sprite = sprite else {
            return
        }
        do {
            guard let sprite = try await environment.imageCacheManager.image(for: sprite).pngData() else {
                return
            }
            let attributes = MonAttributes(sprite: sprite)
            _ = try Activity<MonAttributes>.request(attributes: attributes, contentState: MonAttributes.ContentState())
        } catch {
            print(error.localizedDescription)
        }
    }
}
    .debug()
