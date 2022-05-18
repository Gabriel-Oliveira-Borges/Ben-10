//
//  MyActions.swift
//  testeswiftui WatchKit Extension
//
//  Created by Karen Lima on 17/05/22.
//

import Foundation
import SwiftUI

let action = Action(pages: [
    ActionPage( // 0
        "TAP",
        choices: [
            Choice(text: "Front row!", destination: 1),
            Choice(text: "Find somewhere in the middle", destination: 1),
            Choice(text: "Back of the room", destination: 2),
        ]
    ),
    ActionPage( // 1
        "DRAG",
        choices: [
            Choice(text: "Front row!", destination: 1),
            Choice(text: "Find somewhere in the middle", destination: 1),
            Choice(text: "Back of the room", destination: 2),
        ]
    )
])
        
