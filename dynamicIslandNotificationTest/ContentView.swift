//
//  ContentView.swift
//  dynamicIslandNotificationTest
//
//  Created by Quinten Raymaekers on 28/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var startTime: Date? = nil
    @State private var isTrackingTime: Bool = false
    
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
                    } else {
                        startTime = nil
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
