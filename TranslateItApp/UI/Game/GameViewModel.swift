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
    private let totalQuestionsCount = 15
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
 
    func answer(isCorrect: Bool?) {
        if checkAnswer(userChoice: isCorrect){
            updateCorrectCounter()
        }else{
            updateIncorrectCounter()
        }
        if currentQuestionIndex == totalQuestionsCount - 1 || incorrectCount > 2 {
            endGame()
        }else{
            gameState?(.question(data: questions[currentQuestionIndex]))
            currentQuestionIndex += 1
        }
 
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTime)
        timer?.fire()
    }
 
    private func updateTime(timer: Timer) {
         print("timer", elapsedSeconds)
        if elapsedSeconds > 4 {
            answer(isCorrect: nil)
            elapsedSeconds = 0
        }else {
            elapsedSeconds += 1
        }
    }
    
    private func checkAnswer(userChoice: Bool?) -> Bool{
        guard let userChoice = userChoice else {
            return false
        }
        return userChoice == questions[currentQuestionIndex - 1].isCorrect
    }
    
    private func updateCorrectCounter() {
        correctCount += 1
        correctAnswers?("Correct : \(correctCount)")
    }
    
    private func updateIncorrectCounter() {
        incorrectCount += 1
        incorrectAnswers?("Incorrect : \(incorrectCount)")
     }
    
    private func endGame() {
        timer?.invalidate()
        gameState?(.ended)
    }
    
}
