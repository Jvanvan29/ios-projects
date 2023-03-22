//
//  MonWidget.swift
//  DynamicMons
//
//  Created by Mateus Lino on 19/12/22.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct MonWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MonAttributes.self) { context in
            Image(uiImage: context.attributes.sprite)
                .aspectRatio(contentMode: .fit)
                .frame(height: 32)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading, priority: 4) {
                    Image(uiImage: context.attributes.sprite)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 32)
                }

                DynamicIslandExpandedRegion(.trailing) {
                    Image(uiImage: context.attributes.sprite)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 32)
                }

                DynamicIslandExpandedRegion(.center) {
                    Image(uiImage: context.attributes.sprite)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 32)
                }

                DynamicIslandExpandedRegion(.bottom) {
                    Image(uiImage: context.attributes.sprite)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 32)
                }
            } compactLeading: {
                Image(uiImage: context.attributes.sprite)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 32)
            } compactTrailing: {
                
            } minimal: {
                Image(uiImage: context.attributes.sprite)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 32)
            }
        }
    }
}
