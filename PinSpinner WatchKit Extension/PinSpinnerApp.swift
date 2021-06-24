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
                EnterPinView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
