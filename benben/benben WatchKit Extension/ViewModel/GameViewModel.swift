//
//  GameViewModel.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import Foundation

class GameViewModel: ObservableObject {
    private var actions: [Action] = []
    @Published var currentAction: Action
    
    init() {
        currentAction = actions.randomElement()!
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
        if (type == currentAction.type) {
            nextAction()
        } else {
            print("Wrong Action")
        }
    }
}
