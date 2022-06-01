//
//  GameViewModel.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import Foundation

enum GameState {
    case HOME
    case ENDED
    case PLAYING
    case RIGHTACTION
    case WRONGACTION
}

class GameViewModel: ObservableObject {
    private var actions: [ActionModel] = [DigitalCrownActionModel(), SwipeUpAction(), SwipeDownAction(), SwipeLeftAction(), SwipeRightAction(), TapAction(), LongPressAction()]
    @Published var currentAction: ActionModel?
    @Published var state: GameState = .HOME
    @Published var score: Int = 0
    private let userDefaults = UserDefaultsManager()
    private let soundEffectManager = SoundManager()
    
    init() {
        for var action in actions {
            action.delegate = self
        }
    }
        
    func startGame() {
        score = 0
        nextAction()
        state = .PLAYING
    }
    
    private func stopGame() {
        for var action in actions {
            action.delegate = nil
        }
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
            score += 1
            //soundEffectManager.playSound(sound: .right)
            state = .RIGHTACTION
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                self.state = .PLAYING
                self.nextAction()
            }
            
        } else {
            userDefaults.setMaxScoreIfNeeded(score)
            print("Wrong Action")
            self.stopGame()
            state = .WRONGACTION
            //soundEffectManager.playSound(sound: .wrong)
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                self.state = .ENDED
            }
        }
    }
}
