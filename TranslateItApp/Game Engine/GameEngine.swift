//
//  GameEngine.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

import Foundation

enum GameState {
    case question(pair: WordPair)
 }

final class GameEngine {
    
    public var gameState: ((GameState) -> Void)?
    
    private var questions: WordList = []
    private var currentQuestionIndex = 0
    
    init(loader: WordListLoader, url: URL) {
        loader.loadWords(url: url) { wordList in
            self.questions = wordList
        }
     }
    
    func start() {
        gameState?(.question(pair: questions.first!))
        currentQuestionIndex += 1
    }
    
    func next() {
        gameState?(.question(pair: questions[currentQuestionIndex]))
        currentQuestionIndex += 1
    }
    
}
