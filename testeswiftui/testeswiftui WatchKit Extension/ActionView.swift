//
//  ContentView.swift
//  testeswiftui WatchKit Extension
//
//  Created by Karen Lima on 16/05/22.
//

import SwiftUI

struct ActionView: View {

    var body: some View {
        NavigationView {
            ActionPageView(action: action, pageIndex: 0)
        }
        .navigationViewStyle(.stack)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ActionView()
    }
}

extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}
