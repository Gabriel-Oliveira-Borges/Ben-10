//
//  ActionView.swift
//  benben WatchKit Extension
//
//  Created by Lucas Vieira on 31/05/22.
//

import SwiftUI

struct ActionView: View {
    @ObservedObject var gameViewModel: GameViewModel
    @State var actionText: String = ""
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 15, lineCap: .round))
            Circle()
                //.trim(from: 0, to: 1 - ((defaultTimeRemaining  - timeRemaining)/defaultTimeRemaining))
                .stroke(Color.red, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .rotationEffect(.degrees(-90))
                //.animation(.easeInOut(duration: 1.5), value: timeRemaining)
            VStack(spacing: 10) {
                Text(actionText).onReceive(gameViewModel.$currentAction) { action in
                    actionText = action!.text
                }
                Text("\(gameViewModel.score)")
            }
        }
    }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        ActionView(gameViewModel: GameViewModel())
    }
}
