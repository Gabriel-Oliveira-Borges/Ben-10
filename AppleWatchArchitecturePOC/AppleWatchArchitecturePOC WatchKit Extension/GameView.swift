//
//  GameView.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 18/05/22.
//

import Foundation
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
