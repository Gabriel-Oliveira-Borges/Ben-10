//
//  ShakeSensibility.swift
//  benben WatchKit Extension
//
//  Created by Gabriel Oliveira Borges on 24/05/22.
//

import Foundation

enum ShakeSensibility: Double {
    public typealias RawValue = Double
    case shakeSensibilitySoftest = 0.1
    case shakeSensibilitySoft = 0.7
    case shakeSensibilityNormal = 1.0
    case shakeSensibilityHard = 1.2
    case shakeSensibilityHardest = 2.0
}
