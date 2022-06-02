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
    
    private let ringColors: [Color] = [
        Color(red: 0.36, green: 0.37, blue: 0.87, opacity: 1),
        Color(red: 0.97, green: 0.84, blue: 0.29, opacity: 1),
        Color(red: 0.40, green: 0.80, blue: 0.40, opacity: 1),
        Color(red: 0.98, green: 0.06, blue: 0.79, opacity: 1),
        Color(red: 0.95, green: 0.63, blue: 0.23, opacity: 1),
        Color(red: 0.21, green: 0.52, blue: 0.96, opacity: 1),
        Color(red: 0.69, green: 0.39, blue: 0.91, opacity: 1),
    ]
    @State private var currentRingColor: Color
    
    init(gameViewModel: GameViewModel) {
        self.gameViewModel = gameViewModel
        currentRingColor = ringColors.randomElement()!
    }
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 6, lineCap: .round))
            Circle()
                .trim(from: 0, to: CGFloat(gameViewModel.remainingTimeFraction))
                .stroke(currentRingColor, style: StrokeStyle(lineWidth: 6, lineCap: .round))
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
                        currentRingColor = ringColors.randomElement()!
                    }
                    .font(.system(size: 24, weight: .semibold))
                    Text("\(gameViewModel.score)")
                    .font(.system(size: 19, weight: .light))
                }
            }
        }.onReceive(gameViewModel.$state, perform: { newState in
            switch newState {
                case .PLAYING: WKInterfaceDevice.current().play(.start)
                case .WRONGACTION: WKInterfaceDevice.current().play(.failure)
                case .RIGHTACTION: WKInterfaceDevice.current().play(.success)
                default: do {}
            }
            
        })
        .offset(x: 0, y: 10)
                
        
    }
        

}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        ActionView(gameViewModel: GameViewModel())
    }
}
