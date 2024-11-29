//
//  NotificationWidget.swift
//  NotificationWidget
//
//  Created by Quinten Raymaekers on 28/11/2024.
//

import WidgetKit
import SwiftUI
import ActivityKit

enum ActivityType {
    case sports
    case elections
}


struct NotificationWidget: Widget {
    @State private var activity: Activity<NotificationAttributes>? = nil

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NotificationAttributes.self) { context in
            NotificationWidgetView(context: context)
        }
        dynamicIsland: { context in
            let Type: String = context.state.category
            
            if Type == "Sports" {
                return DynamicIsland {
                    DynamicIslandExpandedRegion(.leading) {
                        HStack {
                            Image("Manchester").resizable().aspectRatio(contentMode: .fill).frame(width: 50, height: 50)
                            Text("1").bold().font(.system(size: 36))
                        }
                    }
                    DynamicIslandExpandedRegion(.center) {
                        Text("87'").bold().font(.system(size: 16)).foregroundStyle(.gray)
                    }
                    DynamicIslandExpandedRegion(.trailing) {
                        
                        HStack {
                            Text("0").bold().font(.system(size: 36))
                            Image("Arsenal").resizable().aspectRatio(contentMode: .fill).frame(width: 50, height: 50)
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
           if Type == "Elections"{
                return DynamicIsland {
                    DynamicIslandExpandedRegion(.leading) {
                        Text("Antwerp").padding(.leading, 14).bold()
                    }
                    DynamicIslandExpandedRegion(.bottom) {
                        HStack {
                            Spacer()
                            ForEach(0..<6) { _ in
                                VStack {
                                    Text("24%").font(.system(size: 12)).bold()
                                    Image("NVA")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 35, height: 35)
                                        .clipShape(Circle())
                                }
                                .frame(maxWidth: .infinity)
                            }
                            Spacer()
                        }.padding(.top, 14)
                    }
                    DynamicIslandExpandedRegion(.trailing) {
                        HStack(alignment: .bottom, spacing: 2) {
                            Text("40")
                                .font(.system(size: 16))
                                .bold()
                            Text("/300")
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                        }
                        .padding(.trailing, 14)
                    }
                } compactLeading: {
                    Text("ANT").padding(.leading, 8)
                } compactTrailing: {
                    HStack {
                        Text("24%").bold()
                        Image("NVA").resizable().aspectRatio(contentMode: .fill).frame(width: 24, height: 24).clipShape(Circle())
                    }
                } minimal: {
                    Text("M")
                }
            }
            return  DynamicIsland {
                // Expanded regions
                DynamicIslandExpandedRegion(.leading) {
                    // Return an empty or minimal view
                    EmptyView()
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    EmptyView()
                }
                
                DynamicIslandExpandedRegion(.center) {
                    EmptyView()
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    EmptyView()
                }
                } compactLeading: {
                    // Minimal content for the compactLeading
                    EmptyView()
                } compactTrailing: {
                    EmptyView()
                } minimal: {
                    EmptyView()
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
