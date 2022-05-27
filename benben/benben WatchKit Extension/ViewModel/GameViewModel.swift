//
//  GameViewModel.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import Foundation


class GameViewModel: ObservableObject {
    @Published var counter: Int
    let userDefaults = UserDefaults.standard
    
    private var actions: [ActionModel] = [DigitalCrownActionModel(), SwipeActionModel(), TapAction()]
    @Published var currentAction: ActionModel
    
    init() {
        currentAction = actions.randomElement()!
        counter = 0
        userDefaults.set(0, forKey: "maxScore")
    }
    
    public func getCounter() -> Int {
        return counter
    }
    public func setCounter(change: Int){
        counter = counter + change
    }
    
    func startGame() {
        for var action in actions {
            action.delegate = self
        }
        setCounter(change: 0)
    }
    
    private func nextAction() {
        currentAction = actions.randomElement()!
        //getCounter()
    }
}

extension GameViewModel: ActionDelegate {
    internal func onDetected(type: ActionType) {
        print("Detected: \(type)")
        print("Expected: \(currentAction.type)")
        if (type == currentAction.type) {
            print("Correct Action")
            setCounter(change: 1)
            if(counter > userDefaults.integer(forKey: "maxScore")){
                userDefaults.set(counter, forKey: "maxScore")
            }
            print(userDefaults.integer(forKey: "maxScore"))
            
            nextAction()
        } else {
            print("Wrong Action")
        }
    }
}
