//
//  FetchMonsDataRequest.swift
//  DynamicMons
//
//  Created by Mateus Lino on 11/12/22.
//

import Foundation

struct FetchStarterMonsDataRequest: DataRequest {
    let route: String = "/starter-mons"
    let method: HTTPMethod = .get
}

struct StarterMon: Decodable, Equatable {
    let mon: Mon
}
