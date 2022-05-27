//
//  ContentView.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 19/05/22.
//

import SwiftUI

struct ContentView: View {
    @State private var crownRotation: Double = 0
    
    private var viewObserver = ViewObserver.newInstance
    
    var body: some View {
        GameView()
            .onTapGesture {
                viewObserver.onTapDetected()
            }
            .gesture(
                DragGesture(minimumDistance: 20, coordinateSpace: .global)
                    .onEnded { value in
                        let horizontalAmount = value.translation.width as CGFloat
                        let verticalAmount = value.translation.height as CGFloat
                        
                        if abs(horizontalAmount) > abs(verticalAmount) {
                            if (horizontalAmount < 0) {
                                viewObserver.onSwipeLeftDetected()
                            } else {
                                viewObserver.onSwipeRightDetected()
                            }
                            
                        } else {
                            if (verticalAmount < 0) {
                                viewObserver.onSwipeUpDetected()
                            } else {
                                viewObserver.onSwipeDownDetected()
                            }
                        }
                    }
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
