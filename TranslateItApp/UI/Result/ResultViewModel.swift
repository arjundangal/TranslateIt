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
        return "\(Constants.Game.correct)\(correctAttempts)"
    }
    
    var incorrectAnswers: String {
        return "\(Constants.Game.incorrect)\(incorrectAttempts)"
    }
    
    private(set) var startNewGame: (() -> Void)
    
    init(correctAttempts: Int, incorrectAttempts: Int, startNewGame: @escaping (() -> Void)) {
        self.correctAttempts = correctAttempts
        self.incorrectAttempts = incorrectAttempts
        self.startNewGame = startNewGame
    }
 
}
