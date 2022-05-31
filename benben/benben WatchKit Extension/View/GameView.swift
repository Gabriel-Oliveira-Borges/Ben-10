//
//  GameView.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameViewModel: GameViewModel = GameViewModel()
    
    init() {
        gameViewModel.startGame()
    }
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 15, lineCap: .round))
            Circle()
                //.trim(from: 0, to: 1 - ((defaultTimeRemaining  - timeRemaining)/defaultTimeRemaining))
                .stroke(Color.red, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .rotationEffect(.degrees(-90))
                //.animation(.easeInOut(duration: 1.5), value: timeRemaining)
            Text(gameViewModel.currentAction.text)
        }
    }
}
