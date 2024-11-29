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

let Type: ActivityType = .sports

var team1Scored: Bool = false;
var team2Scored: Bool = false;

var team1Score: Int = 1
var team2Score: Int = 0

func simulateGoal(team: Int) {
    if team == 1 {
        team1Scored = true
        team1Score += 1
        team2Scored = false
    } else {
        team1Scored = false
        team2Scored = true
        team2Score += 1
    }
    WidgetCenter.shared.reloadAllTimelines()
}

let parties = ["NVA", "PVDA", "VB", "VOORUIT", "GROEN", "CD&V"]
let partyResults = [25.4, 23, 15.8, 12.3, 11.2, 5.4]

struct NotificationWidget: Widget {
    @State private var activity: Activity<NotificationAttributes>? = nil

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NotificationAttributes.self) { context in
            //NotificationWidgetView(context: context)
            
            let columns = [
                    GridItem(.adaptive(minimum: 56)),
                    GridItem(.adaptive(minimum: 56)),
                    GridItem(.adaptive(minimum: 56)),
                    GridItem(.adaptive(minimum: 56)),
                    GridItem(.adaptive(minimum: 56)),
                    GridItem(.adaptive(minimum: 56))
            ]
            
            LazyVGrid(columns: columns, spacing: 5)
            {
                ForEach(0..<parties.count) { i in
                    VStack {
                        //bar chart
                        // party results with one decimal behind the comma
                        let result = String(format: "%.1f", partyResults[i])
                        Text(result + "%")
                            .font(.system(size: 12))
                            .bold()
                            .multilineTextAlignment(.center)
                        Image("\(parties[i])")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                    }
                }
            }
            
        }
        dynamicIsland: { context in
            let Type: String = context.state.category
            
            if (Type == "Sports") {
                return DynamicIsland {
                    DynamicIslandExpandedRegion(.bottom) {
                        HStack {
                            if team1Scored {
                                HStack {
                                    Image("Goal")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                    VStack(alignment: .leading) {
                                        Text("E. Haaland")
                                            .bold()
                                            .font(.system(size: 16))
                                        Text("Assist: K. De Bruyne")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                            } else if team2Scored {
                                Spacer()
                                HStack {
                                    VStack(alignment: .trailing) {
                                        Text("L. Trossard")
                                            .bold()
                                            .font(.system(size: 16))
                                        Text("Assist: B. Saka")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }
                                    Image("Goal")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                }
                            }
                        }
                    }
                    DynamicIslandExpandedRegion(.leading) {
                        HStack {
                            Image("Manchester").resizable().aspectRatio(contentMode: .fill).frame(width: 50, height: 50)
                            Text("\(team1Score)").bold().font(.system(size: 36))
                        }
                    }
                    DynamicIslandExpandedRegion(.center) {
                        Text("87'").bold().font(.system(size: 16)).foregroundStyle(.gray)
                    }
                    DynamicIslandExpandedRegion(.trailing) {
                        
                        HStack {
                            Text("\(team2Score)").bold().font(.system(size: 36))
                            Image("Arsenal").resizable().aspectRatio(contentMode: .fill).frame(width: 50, height: 50)
                        }
                    }
                } compactLeading: {
                    HStack {
                        if !team1Scored {
                            Image("Manchester").resizable().aspectRatio(contentMode: .fill)
                        } else {
                            Image("Goal").resizable().aspectRatio(contentMode: .fill)
                        }
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
                    if (Type == "Elections") {
                        return DynamicIsland {
                            DynamicIslandExpandedRegion(.leading) {
                                Text("Antwerp").padding(.leading, 14).bold()
                            }
                            DynamicIslandExpandedRegion(.bottom) {
                                HStack {
                                    Spacer()
                                    ForEach(0..<parties.count) { i in
                                        VStack {
                                            let result = String(format: "%.1f", partyResults[i])
                                            Text(result + "%").font(.system(size: 12)).bold()
                                            Image("\(parties[i])")
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
                    return DynamicIsland {
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
