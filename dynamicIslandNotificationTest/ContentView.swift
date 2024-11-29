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
    @State public var selectedCategory: Category = .none
    public enum Category: String, CaseIterable, Identifiable {
        case Sports, Elections, none
        var id: Self { self }
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                if (startTime == nil) {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(Category.allCases) { category in
                            if (category != Category.none) {
                                Text(category.rawValue.capitalized)
                            }
                        }
                    }.pickerStyle(.segmented).padding()
                }
                else {
                    Text("\(selectedCategory) is selected")
                }
                Button {
                    isTrackingTime.toggle()
                    
                    if isTrackingTime {
                        startTime = Date()
                        
                        let attributes = NotificationAttributes()
                        let state = NotificationAttributes.ContentState(startTime: Date(), category: selectedCategory.rawValue)
                        
                        activity = try? Activity<NotificationAttributes>.request(attributes: attributes, contentState: state, pushType: nil)
                    } else {
                        guard let startTime else { return }
                        let state = NotificationAttributes.ContentState(startTime: startTime, category: selectedCategory.rawValue)
                        
                        Task {
                            await activity?.end(using: state, dismissalPolicy: .immediate)
                        }
                        
                        self.startTime = nil
                    }
                } label: {
                    Text(isTrackingTime ? "Stop demo" : "Start demo")
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 60)
                        .background(RoundedRectangle(cornerRadius: 10).fill(isTrackingTime ? .red : .green))
                }
                .disabled(selectedCategory == .none)
                .opacity(selectedCategory == .none ? 0.6 : 1.0)
                .navigationTitle(Text("Apple Newton"))
                .navigationBarHidden(true)
            }
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
