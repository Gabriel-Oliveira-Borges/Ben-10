//
//  GameView.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import SwiftUI
import WatchKit

struct GameView: View {
    @ObservedObject var gameViewModel: GameViewModel = GameViewModel()
    @State var actionText: String = ""
    init() {
        gameViewModel.startGame()
    }
    
    var body: some View {
        Text(actionText).onReceive(gameViewModel.$currentAction) { result in
            self.actionText = result!.text
        }
    }
}
