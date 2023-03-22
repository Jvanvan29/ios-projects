//
//  LandingEnvironment.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import Foundation
import ComposableArchitecture

struct LandingEnvironment {
    static let preview = LandingEnvironment(localDatabase: LocalDatabase(), mainQueue: .main)

    let localDatabase: LocalDatabaseProtocol
    let mainQueue: AnySchedulerOf<DispatchQueue>
}
