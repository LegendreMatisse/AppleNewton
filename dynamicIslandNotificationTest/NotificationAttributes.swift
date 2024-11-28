//
//  NotificationAttributes.swift
//  dynamicIslandNotificationTest
//
//  Created by Quinten Raymaekers on 28/11/2024.
//

import Foundation
import ActivityKit

struct NotificationAttributes: ActivityAttributes {
    public typealias NotificationStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var startTime: Date
    }
}
