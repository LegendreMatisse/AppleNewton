//
//  ContentView.swift
//  dynamicIslandNotificationTest
//
//  Created by Quinten Raymaekers on 28/11/2024.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State private var startTime: Date? = nil
    @State private var isTrackingTime: Bool = false
    @State private var activity: Activity<NotificationAttributes>? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                if let startTime {
                    Text(startTime, style: .relative)
                }
                
                Button {
                    isTrackingTime.toggle()
                    
                    if isTrackingTime {
                        startTime = Date()
                        
                        let attributes = NotificationAttributes()
                        let state = NotificationAttributes.ContentState(startTime: Date())
                        
                        activity = try? Activity<NotificationAttributes>.request(attributes: attributes, contentState: state, pushType: nil)
                    } else {
                        guard let startTime else { return }
                        let state = NotificationAttributes.ContentState(startTime: startTime)
                        
                        Task {
                            await activity?.end(using: state, dismissalPolicy: .immediate)
                        }
                        
                        self.startTime = nil
                    }
                } label: {
                    Text(isTrackingTime ? "Stop" : "Start")
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 200)
                        .background(Circle().fill(isTrackingTime ? .red : .green))
                }
                .navigationTitle("Dynamic Island Notification Test")
            }
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
