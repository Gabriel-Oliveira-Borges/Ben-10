//
//  GameViewModel.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import Foundation

class GameViewModel: ObservableObject {
    private var actions: [ActionModel] = [DigitalCrownActionModel(), SwipeActionModel(), TapAction()]
    @Published var currentAction: ActionModel
    @Published var currentTimer: Timer
    
    init() {
        currentAction = actions.randomElement()!
        currentTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func startGame() {
        for var action in actions {
            action.delegate = self
        }
    }
    
    private func nextAction() {
        currentAction = actions.randomElement()!
    }
}

extension GameViewModel: ActionDelegate {
    internal func onDetected(type: ActionType) {
        print("Detected: \(type)")
        print("Expected: \(currentAction.type)")
        if (type == currentAction.type) {
            print("Correct Action")
            nextAction()
        } else {
            print("Wrong Action")
        }
    }
}
