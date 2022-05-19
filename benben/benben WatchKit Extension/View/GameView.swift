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
        Text(gameViewModel.currentAction.text)
    }
}
