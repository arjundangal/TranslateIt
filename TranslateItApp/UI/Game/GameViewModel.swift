//
//  GameViewModel.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

import Foundation

final class GameViewModel {
    
    public var gameState: ((GameState) -> Void)?
    public var correctAnswers: ((String) -> Void)?
    public var incorrectAnswers: ((String) -> Void)?
    
    private var correctCount = 0
    private var incorrectCount = 0
    private var questions: [GameData] = []
    private var currentQuestionIndex = 0
    private let totalQuestionsCount = 20
    
    init(gameDataProvider: GameDataProvider) {
        gameDataProvider.makeData(count: totalQuestionsCount) { gameData in
             self.questions = gameData
         }
    }
    
    func start() {
        correctAnswers?("Correct : \(correctCount)")
        incorrectAnswers?("Incorrect : \(correctCount)")
        gameState?(.question(data: questions.first!))
        currentQuestionIndex += 1
    }
 
    func answer(isCorrect: Bool) {
        checkAnswer(isCorrect: isCorrect)
        if currentQuestionIndex == totalQuestionsCount {
            currentQuestionIndex = 0
        }
        gameState?(.question(data: questions[currentQuestionIndex]))
        currentQuestionIndex += 1
    }
    
    private func checkAnswer(isCorrect: Bool) {
        if isCorrect == questions[currentQuestionIndex - 1].isCorrect {
            updateCorrectCounter()
        }else {
            updateIncorrectCounter()
        }
    }
    
    private func updateCorrectCounter() {
        correctCount += 1
        correctAnswers?("Correct : \(correctCount)")
    }
    
    private func updateIncorrectCounter() {
        incorrectCount += 1
        incorrectAnswers?("Incorrect : \(incorrectCount)")
    }
    
}
