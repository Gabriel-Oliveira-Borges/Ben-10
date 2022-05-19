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
                print("tap")
            }
            .onLongPressGesture {
                print("long press")
                viewObserver.onLongPressDetected()
            }
            .gesture(
                DragGesture(minimumDistance: 20, coordinateSpace: .global)
                    .onEnded { value in
                        viewObserver.onSwipeDetected()
                        print("swip")
                    }
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
