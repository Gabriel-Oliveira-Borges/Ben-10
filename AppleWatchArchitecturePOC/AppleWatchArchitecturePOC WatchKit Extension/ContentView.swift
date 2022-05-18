//
//  ContentView.swift
//  AppleWatchArchitecturePOC WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 16/05/22.
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
            .onLongPressGesture(perform: {
                print("Long press")
            })
            .gesture(
                DragGesture(minimumDistance: 20, coordinateSpace: .global)
                    .onEnded { value in
                        viewObserver.onSwipeDetected()
                        
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
