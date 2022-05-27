//
//  RightActionView.swift
//  benben WatchKit Extension
//
//  Created by Karen Lima on 26/05/22.
//

import SwiftUI

enum feedbackEnum {
    case right
    case wrong
}
struct RightActionView: View {
    var actionFeedback: feedbackEnum
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                if actionFeedback == .wrong {
                    Circle()
                        .strokeBorder(Color("Red"), lineWidth: 6)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 80, height: 70)
                } else {
                    Circle()
                        .strokeBorder(Color("Blue"), lineWidth: 6)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 80, height: 70)
                }
                
            }
            
            
        }
    }
}

struct RightActionView_Previews: PreviewProvider {
    static var previews: some View {
        RightActionView(actionFeedback: .right)
    }
}
