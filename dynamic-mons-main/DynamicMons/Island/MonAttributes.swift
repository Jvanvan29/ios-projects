//
//  MonAttributes.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import ActivityKit
import UIKit

struct MonAttributes: ActivityAttributes {
    private enum CodingKeys: String, CodingKey {
        case sprite
    }

    typealias ContentState = MonState

    struct MonState: Codable, Hashable {}

    private var spriteData: Data
    var sprite: UIImage

    init(sprite: Data) {
        self.spriteData = sprite
        self.sprite = UIImage(data: sprite)!
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        spriteData = try container.decode(Data.self, forKey: .sprite)
        sprite = UIImage(data: spriteData)!
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(spriteData, forKey: CodingKeys.sprite)
    }
}
