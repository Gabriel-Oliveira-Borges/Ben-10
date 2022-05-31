//
//  ScoreModel.swift
//  benben WatchKit Extension
//
//  Created by Hunter Soares do Carmo on 31/05/22.
//

import Foundation


class ScoreModel{
    @Published var counter: Int
    let userDefaults = UserDefaults.standard
    
    init(){
        counter = 0
        userDefaults.set(0, forKey: "maxScore")
    }
    
    public func getCounter() -> Int {
        return counter
    }
    public func setCounter(change: Int){
        counter = counter + change
    }
    
    
    //setCounter(change: 1)
    
    func updateScore(){
        counter = counter + 1
        if(counter > userDefaults.integer(forKey: "maxScore")){
            userDefaults.set(counter, forKey: "maxScore")
    }
    print(userDefaults.integer(forKey: "maxScore"))
    }
    
}
