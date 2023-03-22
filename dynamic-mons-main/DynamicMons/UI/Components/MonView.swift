//
//  MonView.swift
//  DynamicMons
//
//  Created by Mateus Lino on 22/12/22.
//

import SwiftUI

struct MonView: View {
    enum Scale {
        case large
        case regular

        var levelFont: FontStyle {
            switch self {
            case .large:
                return .large
            case .regular:
                return .regular
            }
        }

        var titleFont: FontStyle {
            switch self {
            case .large:
                return .title
            case .regular:
                return .regularMedium
            }
        }

        var imageHeight: CGFloat {
            switch self {
            case .large:
                return 200
            case .regular:
                return 80
            }
        }
    }

    let level: Int
    let imageURL: URL
    let title: String
    let experienceProgress: Double?
    let scale: Scale

    init(level: Int, imageURL: URL, title: String, experienceProgress: Double? = nil, scale: Scale = .regular) {
        self.level = level
        self.imageURL = imageURL
        self.title = title
        self.experienceProgress = experienceProgress
        self.scale = scale
    }

    var body: some View {
        VStack(alignment: .center, spacing: Spacing.main.extraSmall) {
            if experienceProgress != nil {
                Text("Lv. \(level)")
                    .appFont(scale.levelFont)
            }
            LazyImage(url: imageURL)
                .aspectRatio(contentMode: .fit)
                .frame(height: scale.imageHeight)
            HStack {
                Text(title)
                    .appFont(scale.titleFont)
            }
            if let experienceProgress = experienceProgress {
                ProgressView(value: experienceProgress)
                    .frame(width: 80)
            }
        }
        .padding(.all, Spacing.main.large)
    }

    static func skeleton() -> MonView {
        return MonView(
            level: 10,
            imageURL: URL(string: "https://serebii.net/pokemongo/pokemon/004.png")!,
            title: "Charmander",
            experienceProgress: 0.7
        )
    }
}

struct MonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MonView
                .skeleton()
                .padding(Spacing.main.regular)
        }
    }
}
