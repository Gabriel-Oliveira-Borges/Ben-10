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

    @Published var remainingTimeFraction: Float = 1
    @Published var currentAction: ActionModel?
    @Published var state: GameState = .HOME
    @Published var score: Int = 0

    private let userDefaults = UserDefaultsManager()
    private let soundEffectManager = SoundManager()
    var intervalForNextAction = 1.0
    
    private let timer = TimerProvider(totalTime: 5)
    private var actions: [ActionModel] = [DigitalCrownActionModel(), SwipeUpAction(), SwipeDownAction(), SwipeLeftAction(), SwipeRightAction(), TapAction(),    LongPressAction()]
        
    func startGame() {
        for var action in actions {
            action.delegate = self
        }
        score = 0
        nextAction()
        state = .PLAYING
        timer.delegate = self
        timer.start()
    }
    
    func getTimerPublisher() -> Timer.TimerPublisher {
        return timer.publisher
    }
    
    func updateRemainingTime() {
        timer.uptadeRemainingTime()
        remainingTimeFraction = 1 - (((Float(timer.totalTime)  - Float(timer.remainingTime!))/Float(timer.totalTime)))

    }
    
    func reestartTimerWithNewAction() {
        score += 1
        self.timer.reset()
        soundEffectManager.playSound(sound: .right)
        state = .RIGHTACTION
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            self.timer.start()
            self.state = .PLAYING
            self.nextAction()
        }
    }
    
    private func endGame() {
        userDefaults.setMaxScoreIfNeeded(score)
        self.stopGame()
        state = .WRONGACTION
        soundEffectManager.playSound(sound: .wrong)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            self.state = .ENDED
        }
    }
    
    private func stopGame() {
        for var action in actions {
            action.delegate = nil
        }
        self.timer.cancel()
        self.remainingTimeFraction = 1
    }
    
    private func nextAction() {
        (currentAction as? ShakeActionModel)?.stopDetection()
        currentAction = actions.randomElement()!
        soundEffectManager.playSound(sound: currentAction!.type)
        (currentAction as? ShakeActionModel)?.startDetection()
    }
}

extension GameViewModel: ActionDelegate {
    
    internal func onDetected(type: ActionType) {
        if (type == currentAction?.type) {
            self.reestartTimerWithNewAction()
        } else {
            self.endGame()
        }
    }
}

extension GameViewModel: TimerProviderDelegate {
    func timerDidEnd() {
        self.endGame()
    }
    
    func timerDidReset() {
        self.remainingTimeFraction = 1
    }
}
