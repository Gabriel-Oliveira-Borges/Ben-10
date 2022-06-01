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
    private let soundEffectManager = SoundManager()
    var body: some View {
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 6, lineCap: .round))
            Circle()
                .trim(from: 0, to: CGFloat(gameViewModel.remainingTimeFraction))
                .stroke(Color.red, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .rotationEffect(.degrees(-90))
                //.animation(.easeInOut(duration: 1.5), value: timeRemaining)
                .onReceive(gameViewModel.getTimerPublisher()) { _ in
                    withAnimation(.easeInOut(duration: 1.5)) {
                        gameViewModel.updateRemainingTime()
                    }
                }
            if gameViewModel.state == .WRONGACTION {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 80, height: 70)
            } else if gameViewModel.state == .RIGHTACTION {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 80, height: 70)
            } else {
                VStack(spacing: 10) {
                    Text(actionText).onReceive(gameViewModel.$currentAction) { action in
                        actionText = action!.text
                    }
                    .font(.system(size: 24, weight: .semibold))
                    Text("\(gameViewModel.score)")
                    .font(.system(size: 19, weight: .light))
                }
            }
        }
        .onAppear {
            if gameViewModel.state == .WRONGACTION {
                soundEffectManager.playSound(sound: .wrong)
            } else if gameViewModel.state == .RIGHTACTION {
                soundEffectManager.playSound(sound: .right)
            } else {
                soundEffectManager.playSound(sound: gameViewModel.currentAction!.type)
            }
            
        }
        .offset(x: 0, y: 10)
                
        
    }
        

}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        ActionView(gameViewModel: GameViewModel())
    }
}
