//
//  GameEngine.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

import Foundation

enum GameState {
    case question(data: GameData)
 }

final class GameEngine {
    
    public var gameState: ((GameState) -> Void)?
    
    private var questions: [GameData] = []  
    private var currentQuestionIndex = 0
    
    init(gameDataProvider: GameDataProvider) {
        gameDataProvider.makeData(count: 5) { gameData in
            self.questions = gameData
        }
    }
    
    func start() {
        gameState?(.question(data: questions.first!))
        currentQuestionIndex += 1
    }
    
    func next() {
        gameState?(.question(data: questions[currentQuestionIndex]))
        currentQuestionIndex += 1
    }
    
}
