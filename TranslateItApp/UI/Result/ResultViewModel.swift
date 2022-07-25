//
//  ResultViewModel.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 25/7/2022.
//

import RxRelay

final class ResultViewModel {
    
    private let correctAttempts: Int
    private let incorrectAttempts: Int
    
    var correctAnswers: String {
        return "Correct: \(correctAttempts)"
    }
    
    var incorrectAnswers: String {
        return "Incorrect: \(incorrectAttempts)"
    }
    
    private(set) var startNewGame: PublishRelay<Void>
    
   init(correctAttempts: Int, incorrectAttempts: Int, startNewGame: PublishRelay<Void>) {
        self.correctAttempts = correctAttempts
        self.incorrectAttempts = incorrectAttempts
        self.startNewGame = startNewGame
    }
 
}
