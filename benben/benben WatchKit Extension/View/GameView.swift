//
//  GameView.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameViewModel: GameViewModel = GameViewModel()
    @State var actionText: String = ""
    
    var body: some View {
        switch gameViewModel.state {
        case .HOME:
            StartGameView(highScore: 30, gameViewModel: gameViewModel)
        case .PLAYING:
            ZStack{
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 15, lineCap: .round))
                Circle()
                    //.trim(from: 0, to: 1 - ((defaultTimeRemaining  - timeRemaining)/defaultTimeRemaining))
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    //.animation(.easeInOut(duration: 1.5), value: timeRemaining)
                Text(actionText).onReceive(gameViewModel.$currentAction) { action in
                    actionText = action!.text
                }             
            }
        case .RIGHTACTION:
            FeedbackActionView(actionFeedback: .right)
        case .WRONGACTION:
            FeedbackActionView(actionFeedback: .wrong)
        case .ENDED:
            EndGameView(endGameTitle: "Final score:", finalScore: 20, gameViewModel: gameViewModel)
        }
    }
}
