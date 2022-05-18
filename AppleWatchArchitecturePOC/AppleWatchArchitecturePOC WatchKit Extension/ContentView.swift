//
//  ContentView.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 16/05/22.
//

import SwiftUI
//import Combine

struct ContentView: View {
    @State private var crownRotation: Double = 0
    
    private var digitalCrownObserver = DigitalCrownObserver.newInstance
    private var tapGestureObserver = TapGestureObserver.newInstance
    private var swipeGestureObserver = SwipeGestureObserver.newInstance

    var body: some View {
        GameView()
            .onTapGesture {
                self.digitalCrownObserver.didRotateDigitalCrown = false
                self.swipeGestureObserver.didSwipe = false
                self.tapGestureObserver.didTap = true
            }
            .gesture(
                DragGesture(minimumDistance: 20, coordinateSpace: .global)
                    .onEnded { value in
                        self.digitalCrownObserver.didRotateDigitalCrown = false
                        self.swipeGestureObserver.didSwipe = true
                        self.tapGestureObserver.didTap = false
                        
                        
                        let horizontalAmount = value.translation.width as CGFloat
                        let verticalAmount = value.translation.height as CGFloat
                        
                        if abs(horizontalAmount) > abs(verticalAmount) {
                            if (horizontalAmount < 0) {
                                //SwipeLeft
//                                print("SwipeLeft")
                            } else {
                                //SwipeRight
//                                print("SwipeRight")
                            }
                            
                        } else {
                            if (verticalAmount < 0) {
                                //SwipeUp
//                                print("SwipeUp")
                            } else {
                                //SwipeDown
//                                print("SwipeDown")
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
