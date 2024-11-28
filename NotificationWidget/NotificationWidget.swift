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
                    HStack {
                        Image("Manchester").resizable().aspectRatio(contentMode: .fill)
                        Text("1")
                    }
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("87")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    HStack {
                        Text("0")
                        Image("Arsenal").resizable().aspectRatio(contentMode: .fill)
                    }
                }
            } compactLeading: {
                HStack {
                    Image("Manchester").resizable().aspectRatio(contentMode: .fill)
                    Text("1")
                }
            } compactTrailing: {
                HStack {
                    Text("0")
                    Image("Arsenal").resizable().aspectRatio(contentMode: .fill)
                }
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
