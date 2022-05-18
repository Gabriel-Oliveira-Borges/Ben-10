//
//  testeswiftuiApp.swift
//  testeswiftui WatchKit Extension
//
//  Created by Karen Lima on 16/05/22.
//

import SwiftUI

@main
struct testeswiftuiApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ActionView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
