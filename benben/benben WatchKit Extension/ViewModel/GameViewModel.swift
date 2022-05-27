//
//  GameViewModel.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import Foundation

enum GameState {
    case ENDED
    case PLAYING
    case RIGHTACTION
    case WRONGACTION
}

class GameViewModel: ObservableObject {
    private var actions: [ActionModel] = [DigitalCrownActionModel(), SwipeActionModel(), TapAction(), LongPressAction()]
    private let soundEffectManager = SoundManager()
    @Published var currentAction: ActionModel
    @Published var state: GameState
    
    init() {
        currentAction = actions.randomElement()!
        state = .PLAYING
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
            soundEffectManager.playSound(sound: .right)
            state = .RIGHTACTION
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                self.state = .PLAYING
                self.nextAction()
            }
            
        } else {
            print("Wrong Action")
            state = .WRONGACTION
            soundEffectManager.playSound(sound: .wrong)
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                self.state = .ENDED
            }
        }
    }
}
