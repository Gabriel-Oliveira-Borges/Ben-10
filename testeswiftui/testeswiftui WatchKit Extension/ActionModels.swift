//
//  ActionModels.swift
//  testeswiftui WatchKit Extension
//
//  Created by Karen Lima on 17/05/22.
//

import Foundation

struct Action {
    
    let pages: [ActionPage]

    subscript(_ pageIndex: Int) -> ActionPage {
        return pages[pageIndex]
    }
}

struct ActionPage {
    let text: String
    
    let choices: [Choice]
    
    init(_ text: String, choices: [Choice]) {
        self.text = text
        self.choices = choices
    }
}

struct Choice {
    let text: String
    let destination: Int
}
