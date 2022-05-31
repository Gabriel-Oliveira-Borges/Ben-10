//
//  GameView.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameViewModel: GameViewModel = GameViewModel()
    private let soundEffectManager = SoundManager()
    @State var actionText: String = ""
    
    var body: some View {
        switch gameViewModel.state {
        case .HOME:
            StartGameView(highScore: 30, gameViewModel: gameViewModel)
        case .PLAYING:
            Text(actionText)
                .onReceive(gameViewModel.$currentAction) { action in
                    actionText = action!.text
                    soundEffectManager.playSound(sound: action!.type)
                }
                .font(.system(size: 24, weight: .semibold))
        case .RIGHTACTION:
            FeedbackActionView(actionFeedback: .right)
        case .WRONGACTION:
            FeedbackActionView(actionFeedback: .wrong)
        case .ENDED:
            EndGameView(endGameTitle: "Final score:", finalScore: 20, gameViewModel: gameViewModel)
        }
    }
}
