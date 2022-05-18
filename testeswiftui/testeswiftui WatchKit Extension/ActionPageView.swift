//
//  ActionPageView.swift
//  testeswiftui WatchKit Extension
//
//  Created by Karen Lima on 17/05/22.
//

import SwiftUI

struct ActionPageView: View {
    @State private var color : Color = Color.primary
    @State private var offset = CGSize.zero
    @State private var sizeIndex = 0
    @State private var identifiedGesture: Int?
    
    var sizes: [CGSize] = [
        CGSize(width: 150, height: 80),
        CGSize(width: 200, height: 40),
        CGSize(width: 50, height: 250),
        CGSize(width: 220, height: 100),
        CGSize(width: 90, height: 90),
    ]
    
    let action: Action
    let pageIndex: Int
    
    var tapGesture: some Gesture {
        TapGesture()
            .onEnded {
                print("Deu um tap")
                withAnimation {
                    color = .red
                }
            identifiedGesture = 0
            }
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged {value in
                offset = CGSize(width: value.startLocation.x + value.translation.width - 50,
                                height: value.startLocation.y + value.translation.height - 50)
                print("Deu um drag")
                withAnimation {
                    color = .blue
                }
                identifiedGesture = 1
            }
    }
    
    var longPressGesture: some Gesture {
        LongPressGesture()
            .onEnded {value in
                withAnimation {
                    color = .green
                    sizeIndex += 1
                    if sizeIndex == sizes.count {
                        sizeIndex = 0
                    }
                }
                print("Deu um long press")
                identifiedGesture = 2
            }
    }
    
    var body: some View {
        VStack {
            Text(action[pageIndex].text)
            Spacer()
//            NavigationLink(destination: ActionPageView(action: action, pageIndex: 1)) {
//                Text("hello")
//                    .foregroundColor(color)
//                    .frame(width: sizes[sizeIndex].width, height: sizes[sizeIndex].height)
//                    .offset(offset)
//                    .gesture(tapGesture)
//                    .gesture(longPressGesture)
//                    .gesture(dragGesture)
//            }
            Rectangle()
                .foregroundColor(color)
                .frame(width: sizes[sizeIndex].width, height: sizes[sizeIndex].height)
                .offset(offset)
                .gesture(tapGesture)
                .gesture(longPressGesture)
                .gesture(dragGesture)
            Spacer()
        }
        
    }
}

struct ActionPageView_Previews: PreviewProvider {
    static var previews: some View {
        ActionPageView(action: action, pageIndex: 0)
    }
}

