//
//  ScoreModel.swift
//  benben WatchKit Extension
//
//  Created by Hunter Soares do Carmo on 31/05/22.
//

import Foundation

class UserDefaultsManager {
    private let MAX_SCORE = "MAX_SCORE"
    private let userDefaults: UserDefaults = UserDefaults.standard
    
    
    func getMaxScore() -> Int {
        return userDefaults.integer(forKey: MAX_SCORE)
    }
    
    func setMaxScoreIfNeeded(_ newValue: Int) {
        if (newValue > getMaxScore()) {
            userDefaults.set(newValue, forKey: MAX_SCORE)
        }
    }
}
