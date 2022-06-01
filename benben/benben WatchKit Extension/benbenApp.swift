//
//  benbenApp.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import SwiftUI
import Combine

@main
struct benbenApp: App {
    @State private var crownRotation: Double = 0
    @Environment(\.scenePhase) private var scenePhase
    private let soundBackManager = SoundManager()
    
    
    private var viewObserver = ViewObserver.newInstance
    
    private let relay = PassthroughSubject<Double, Never>()
    private let debouncedPublisher: AnyPublisher<Double, Never>
    
    init() {
        debouncedPublisher = relay
            .removeDuplicates()
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
        soundBackManager.playSound(sound: .back)
    }

    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack{
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
                            self.viewObserver.onDigitalCrownDetected()
                        })
                        .onChange(of: scenePhase) { phase in
                            if phase == .active {
                                soundBackManager.playSound(sound: .back)
                            } else {
                                soundBackManager.stopSound()

                            }
                        }
                }
                    
                }
            }
        }
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
