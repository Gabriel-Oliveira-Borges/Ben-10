//
//  GameView.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameViewModel: GameViewModel = GameViewModel()
    var soundManager = SoundManager()
    var body: some View {
        switch gameViewModel.state {
        case .HOME:
            StartGameView(gameViewModel: gameViewModel)
        case .PLAYING, .WRONGACTION, .RIGHTACTION:
            ActionView(gameViewModel: gameViewModel)
        case .ENDED:
            EndGameView(gameViewModel: gameViewModel)
        }
    }
}
