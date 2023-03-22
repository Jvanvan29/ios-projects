//
//  Date+Distance.swift
//  DynamicMons
//
//  Created by Mateus Lino on 21/12/22.
//

import Foundation

extension Date {
    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        return calendar.dateComponents([component], from: self, to: date).value(for: component)
    }
}
