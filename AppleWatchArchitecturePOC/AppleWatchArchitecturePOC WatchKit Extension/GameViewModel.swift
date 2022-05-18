//
//  GameViewModel.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 17/05/22.
//

import Foundation

enum GameViewModelViewAction {
    case CorrectAction
    case WrongAction
}

class GameViewModel: ObservableObject {
    private var actions: [Action] = [SwipeAction(), TapAction(), DigitalCrownAction()]
    @Published var currentAction: Action
    
    init() {
        actions.shuffle()
        currentAction = actions[0]
    }

    func startGame() {
        for var action in actions {
            action.delegate = self
        }
    }
    
    private func nextAction() {
        actions.shuffle()
        currentAction = actions[0]
    }
}

extension GameViewModel: ActionDelegate {
    internal func onDetected(kind: ActionKind) {
        print(kind)
        print(currentAction.kind)
        if (kind == currentAction.kind) {
            print("Correct Action")
            nextAction()
        } else {
            print("Wrong Action")
        }
    }
}
