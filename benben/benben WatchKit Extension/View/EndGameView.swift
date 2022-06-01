//
//  EndGameView.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 25/05/22.
//

import SwiftUI

struct EndGameView: View {
    var gameViewModel: GameViewModel
    private var endGameTitle: String
    private let shownScore: Int
    private let userDefaults = UserDefaultsManager()
    
    init(gameViewModel: GameViewModel) {
        self.gameViewModel = gameViewModel
        
        let highScore = userDefaults.getMaxScore()
        let currentScore = gameViewModel.score
        self.shownScore = currentScore
        if (highScore == currentScore) {
            self.endGameTitle = "New high score:"
        } else {
            self.endGameTitle = "Final score:"
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(endGameTitle)
                .font(.system(size: 24, weight: .semibold))
            Spacer()
            Text("\(shownScore)")
                .font(.system(size: 30, weight: .semibold))
            Spacer()
            HStack {
                Button(action: {
                    gameViewModel.state = .PLAYING
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                        .frame(width: 34, height: 40)
                        .padding(15)
                        .foregroundColor(Color("Blue"))
                    }
                .frame(width: 62, height: 62)
                .cornerRadius(360)
                Spacer()
                Button(action: {
                    gameViewModel.state = .HOME
                }) {
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 40, height: 35)
                        .padding(15)
                        .foregroundColor(Color("Blue"))
                    }
                .frame(width: 62, height: 62)
                .cornerRadius(360)
            }
        }
        
    }
}

struct EndGameView_Previews: PreviewProvider {
    static var previews: some View {
        EndGameView(gameViewModel: GameViewModel())
    }
}
