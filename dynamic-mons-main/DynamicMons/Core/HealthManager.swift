//
//  HealthManager.swift
//  DynamicMons
//
//  Created by Mateus Lino on 20/12/22.
//

import Combine
import Foundation
import HealthKit

protocol HealthManagerProtocol {
    func getBurnedEnergy() async throws -> Double
}

final class HealthManager: HealthManagerProtocol {
    private let healthKitStore: HKHealthStore

    init(healthKitStore: HKHealthStore = HKHealthStore()) {
        self.healthKitStore = healthKitStore
    }

    func getBurnedEnergy() async throws -> Double {
        let activitySummaryType = HKObjectType.activitySummaryType()

        return try await withCheckedThrowingContinuation { continuation in
            healthKitStore.requestAuthorization(toShare: nil, read: [activitySummaryType]) { success, error in
                guard success else {
                    continuation.resume(throwing: error ?? GenericError())
                    return
                }

                let calendar = Calendar.autoupdatingCurrent

                var dateComponents = calendar.dateComponents(
                    [.year, .month, .day],
                    from: Date()
                )

                dateComponents.calendar = calendar

                let predicate = HKQuery.predicateForActivitySummary(with: dateComponents)

                let query = HKActivitySummaryQuery(predicate: predicate) { (_, summaries, error) in
                    if let summaries = summaries, let summary = summaries[safe: 0] {
                        let energyUnit = HKUnit.kilocalorie()
                        let energy = summary.activeEnergyBurned.doubleValue(for: energyUnit)

                        continuation.resume(returning: energy)
                    } else {
                        continuation.resume(throwing: error ?? GenericError())
                    }
                }

                self.healthKitStore.execute(query)
            }
        }
    }
}
