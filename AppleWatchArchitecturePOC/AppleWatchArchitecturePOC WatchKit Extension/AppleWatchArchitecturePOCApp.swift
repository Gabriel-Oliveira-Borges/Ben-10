//
//  AppleWatchArchitecturePOCApp.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 16/05/22.
//

import SwiftUI
import Combine

@main
struct AppleWatchArchitecturePOCApp: App {
    @State private var crownRotation: Double = 0
    
    private var digitalCrownObserver = DigitalCrownObserver.newInstance
    private var tapGestureObserver = TapGestureObserver.newInstance
    private var swipeGestureObserver = SwipeGestureObserver.newInstance
    
    private let relay = PassthroughSubject<Double, Never>()
    private let debouncedPublisher: AnyPublisher<Double, Never>
    
    init() {
        debouncedPublisher = relay
            .removeDuplicates()
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack {
                    ContentView()
                        .focusable()
                        .digitalCrownRotation(
                            $crownRotation,
                            from: 0,
                            through: 5,
                            by: 2.5,
                            sensitivity: .low,
                            isContinuous: true,
                            isHapticFeedbackEnabled: true
                        )
                        .onChange(of: crownRotation) { rotation in
                            relay.send(rotation)
                        }.onReceive(debouncedPublisher, perform: { digitalCrownValue in                            
                            self.digitalCrownObserver.didRotateDigitalCrown = true
                            self.swipeGestureObserver.didSwipe = false
                            self.tapGestureObserver.didTap = false
                            
                        })
                }
            }
        }
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
