//
//  DynamicIslandServiceLiveActivity.swift
//  DynamicIslandService
//
//  Created by Jérémy Vander Motte on 28/11/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DynamicIslandServiceAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DynamicIslandServiceLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicIslandServiceAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DynamicIslandServiceAttributes {
    fileprivate static var preview: DynamicIslandServiceAttributes {
        DynamicIslandServiceAttributes(name: "World")
    }
}

extension DynamicIslandServiceAttributes.ContentState {
    fileprivate static var smiley: DynamicIslandServiceAttributes.ContentState {
        DynamicIslandServiceAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DynamicIslandServiceAttributes.ContentState {
         DynamicIslandServiceAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DynamicIslandServiceAttributes.preview) {
   DynamicIslandServiceLiveActivity()
} contentStates: {
    DynamicIslandServiceAttributes.ContentState.smiley
    DynamicIslandServiceAttributes.ContentState.starEyes
}
