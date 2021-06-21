//
//  PinSpinnerApp.swift
//  PinSpinner WatchKit Extension
//
//  Created by user198417 on 6/21/21.
//

import SwiftUI

@main
struct PinSpinnerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(numberOfDigits: 4)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
