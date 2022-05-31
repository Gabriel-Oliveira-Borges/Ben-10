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
    @Published var ScoreGame: ScoreModel = ScoreModel()
    
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
    
    public func getScoreGame() -> Int{
        return ScoreGame.getCounter()
    }
}

    

extension GameViewModel: ActionDelegate {
    internal func onDetected(type: ActionType) {
        print("Detected: \(type)")
        print("Expected: \(currentAction.type)")
        if (type == currentAction.type) {
            print("Correct Action")
            ScoreGame.setCounter(change: 1)
            nextAction()
        } else {
            ScoreGame.updateMaxScore()
            print("Wrong Action")
        }
    }
}
