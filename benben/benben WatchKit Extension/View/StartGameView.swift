//
//  StartGameView.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 27/05/22.
//

import SwiftUI

struct StartGameView: View {
    var highScore = 10
    var gameViewModel: GameViewModel
    
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
