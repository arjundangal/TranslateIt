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
    private var elapsedSeconds = 0
    private var timer:Timer?
    
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
        startTimer()
      }
 
    func answer(isCorrect: Bool) {
        checkAnswer(isCorrect: isCorrect)
        if currentQuestionIndex == totalQuestionsCount {
            currentQuestionIndex = 0
        }
        gameState?(.question(data: questions[currentQuestionIndex]))
        currentQuestionIndex += 1
        elapsedSeconds = 0
     }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTime)
        timer?.fire()
    }
 
    private func updateTime(timer: Timer) {
         print("timer", elapsedSeconds)
        if elapsedSeconds > 3 {
            answer(isCorrect: false)
            elapsedSeconds = 0
        }else {
            elapsedSeconds += 1
        }
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
