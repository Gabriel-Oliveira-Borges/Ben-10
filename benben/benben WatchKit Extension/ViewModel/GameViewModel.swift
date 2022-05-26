//
//  GameViewModel.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import Foundation

class GameViewModel: ObservableObject {
    private var actions: [ActionModel] = [DigitalCrownActionModel(), SwipeActionModel(), TapAction(), PunchAction(), WatchDownAction(), WatchUpAction(), ShakeAction(), CelebrateAction()]
    @Published var currentAction: ActionModel?
    
    func startGame() {
        for var action in actions {
            action.delegate = self
        }
        
        nextAction()
    }
    
    private func nextAction() {
        (currentAction as? ShakeActionModel)?.stopDetection()
        currentAction = actions.randomElement()!
        (currentAction as? ShakeActionModel)?.startDetection()
    }
}

extension GameViewModel: ActionDelegate {
    internal func onDetected(type: ActionType) {
        print("")
        print("")
        print("#################################")
        print("Detected: \(type)")
        print("Expected: \(currentAction!.type)")
        if (type == currentAction?.type) {
            print("Correct Action")
            nextAction()
        } else {
            print("Wrong Action")
        }
    }
}
