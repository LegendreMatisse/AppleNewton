//
//  NotificationWidget.swift
//  NotificationWidget
//
//  Created by Quinten Raymaekers on 28/11/2024.
//

import WidgetKit
import SwiftUI
import ActivityKit

struct NotificationWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NotificationAttributes.self) { context in
            NotificationWidgetView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("MAIN")
                }
            } compactLeading: {
                Text("CL")
            } compactTrailing: {
                Text("CT")
            } minimal: {
                Text("M")
            }

        }
    }
}

struct NotificationWidgetView: View {
    let context: ActivityViewContext<NotificationAttributes>
    
    var body: some View {
        Text(context.state.startTime, style: .relative)
    }
}
