//
//  Mon.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import ActivityKit
import GRDB
import SwiftUI

struct Mon: Record, Equatable, ActivityAttributes {
    typealias ContentState = MonState

    struct MonState: Codable, Hashable {}

    enum MonType: String, Codable, Equatable {
        case bug = "Bug"
        case dark = "Dark"
        case dragon = "Dragon"
        case electric = "Electric"
        case fighting = "Fighting"
        case fire = "Fire"
        case flying = "Flying"
        case ghost = "Ghost"
        case grass = "Grass"
        case ground = "Ground"
        case ice = "Ice"
        case normal = "Normal"
        case poison = "Poison"
        case psychic = "Psychic"
        case rock = "Rock"
        case steel = "Steel"
        case water = "Water"

        var description: String {
            return self.rawValue.uppercased()
        }

        var color: Color {
            switch self {
            case .bug:
                return Color(r: 255, g: 255, b: 255)
            case .dark:
                return Color(r: 255, g: 255, b: 255)
            case .dragon:
                return Color(r: 255, g: 255, b: 255)
            case .electric:
                return Color(r: 255, g: 255, b: 255)
            case .fighting:
                return Color(r: 255, g: 255, b: 255)
            case .fire:
                return Color(r: 239, g: 128, b: 48)
            case .flying:
                return Color(r: 255, g: 255, b: 255)
            case .ghost:
                return Color(r: 255, g: 255, b: 255)
            case .grass:
                return Color(r: 120, g: 200, b: 79)
            case .ground:
                return Color(r: 255, g: 255, b: 255)
            case .ice:
                return Color(r: 255, g: 255, b: 255)
            case .normal:
                return Color(r: 168, g: 168, b: 119)
            case .poison:
                return Color(r: 255, g: 255, b: 255)
            case .psychic:
                return Color(r: 255, g: 255, b: 255)
            case .rock:
                return Color(r: 255, g: 255, b: 255)
            case .steel:
                return Color(r: 255, g: 255, b: 255)
            case .water:
                return Color(r: 255, g: 255, b: 255)
            }
        }
    }

    private static var initialLevel: Int = 5

    var id: Int64?
    var imageURL: URL
    var sprite: URL
    var name: String
    var type: MonType
    var level: Int
    var experience: Double

    var requiredExperience: Double {
        return Self.requiredExperience(for: level + 1)
    }

    var experienceProgress: Double {
        return (experience - Self.requiredExperience(for: level)) / requiredExperience
    }

    init(
        id: Int64?,
        imageURL: URL,
        sprite: URL,
        name: String,
        type: MonType,
        level: Int = Self.initialLevel,
        experience: Double? = nil
    ) {
        self.id = id
        self.imageURL = imageURL
        self.sprite = sprite
        self.name = name
        self.type = type
        self.level = level
        self.experience = experience ?? Self.requiredExperience(for: level)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id)
        self.imageURL = try container.decode(URL.self, forKey: .imageURL)
        self.sprite = try container.decode(URL.self, forKey: .sprite)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(Mon.MonType.self, forKey: .type)
        self.level = try container.decodeIfPresent(Int.self, forKey: .level) ?? 0
        self.experience = try container.decodeIfPresent(Double.self, forKey: .experience) ?? Self.requiredExperience(for: level)
    }

    private static func requiredExperience(for level: Int) -> Double {
        return Double(level * 100) * 1.5
    }
}

extension Mon {
    static var databaseTableName: String {
        return "mon"
    }

    static func createTable(using database: DatabaseProtocol, completion: (() -> Void)?) throws {
        try database.create(table: Self.databaseTableName) { table in
            table.autoIncrementedPrimaryKey("id")
            table.column("imageURL", .text).notNull()
            table.column("sprite", .text).notNull()
            table.column("name", .text).notNull()
            table.column("type", .text).notNull()
            table.column("experience", .double).notNull()
            completion?()
        }
    }
}
