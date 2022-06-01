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

    @Published var state: GameState = .HOME
    @Published var currentAction: ActionModel?
    @Published var remainingTimeFraction: Float = 1
    
    private let soundEffectManager = SoundManager()
    private let timer = TimerProvider(totalTime: 5)
    private var actions: [ActionModel] = [DigitalCrownActionModel(), SwipeUpAction(), SwipeDownAction(), SwipeLeftAction(), SwipeRightAction(), TapAction(), PunchAction(), WatchDownAction(), WatchUpAction(), ShakeAction(), CelebrateAction(), LongPressAction()]
    
    
    init() {
        for var action in actions {
            action.delegate = self
        }
    }
        
    func startGame() {
        nextAction()
        state = .PLAYING
        timer.start()
    }
    
    func getTimerPublisher() -> Timer.TimerPublisher {
        return timer.publisher
    }
    
    func updateRemainingTime() {
        timer.uptadeRemainingTime()
        remainingTimeFraction = 1 - (((Float(timer.totalTime)  - Float(timer.remainingTime!))/Float(timer.totalTime)))

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
            soundEffectManager.playSound(sound: .right)
            state = .RIGHTACTION
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                self.state = .PLAYING
                self.nextAction()
            }
            
        } else {
            print("Wrong Action")
            self.stopGame()
            state = .WRONGACTION
            soundEffectManager.playSound(sound: .wrong)
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                self.state = .ENDED
            }
        }
    }
}
