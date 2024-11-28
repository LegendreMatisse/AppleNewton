//
//  DynamicIslandServiceBundle.swift
//  DynamicIslandService
//
//  Created by Jérémy Vander Motte on 28/11/2024.
//

import WidgetKit
import SwiftUI

@main
struct DynamicIslandServiceBundle: WidgetBundle {
    var body: some Widget {
        DynamicIslandService()
        DynamicIslandServiceControl()
        DynamicIslandServiceLiveActivity()
    }
}
