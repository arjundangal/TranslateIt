//
//  GameDataProvider.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

import Foundation
 
final class GameDataProvider {
    
    private let loader: WordListLoader
    
    init(loader: WordListLoader) {
        self.loader = loader
    }

    func makeData(count: Int, completion: @escaping ([GameData]) -> Void){
        
        loader.loadWords { questions in
            let roundsQuestion = questions.shuffled().prefix(count)
            let correctPairsCount = Int(Double(count) * 0.25)
            let correctPairs = roundsQuestion.shuffled().prefix(correctPairsCount).map{
                GameData(question: $0.originalWord, answer: $0.translatedWord, isCorrect: true)
            }
            let remainingQuestions = roundsQuestion.suffix(roundsQuestion.count - correctPairsCount)
            let randomAnswers = remainingQuestions.map{$0.translatedWord}.shuffled()
            
            let incorrectPairs = remainingQuestions.map{ pair -> GameData in
                let answer = randomAnswers.randomElement() ?? pair.translatedWord
                return GameData(question: pair.originalWord, answer: answer, isCorrect: answer == pair.translatedWord)
             }

            completion((correctPairs + incorrectPairs).shuffled())
        }
    }
}
