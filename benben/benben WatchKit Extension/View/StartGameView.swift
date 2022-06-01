//
//  StartGameView.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 27/05/22.
//

import SwiftUI

struct StartGameView: View {
    @State var highScore: Int
    var gameViewModel: GameViewModel
    private let userDefaults = UserDefaultsManager()
    
    init(gameViewModel: GameViewModel) {
        self.gameViewModel = gameViewModel
        self.highScore = userDefaults.getMaxScore()
    }
    
    var body: some View {
        VStack {
            Text("High score:")
                .font(.system(size: 24, weight: .semibold))
            Spacer()
            Text("\(highScore)")
                .font(.system(size: 30, weight: .semibold))
            Spacer()
            Button {
                gameViewModel.startGame()
            } label: {
                Text("Start game!")
                    .foregroundColor(.black)
                    
            }
            .background(Color("Blue"))
            .cornerRadius(22)
        }
        
        
    }
}

struct StartGameView_Previews: PreviewProvider {
    static var previews: some View {
        StartGameView(gameViewModel: GameViewModel())
    }
}
