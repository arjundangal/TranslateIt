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

    func makeData(roundCount: Int, roundDuration: Double, completion: @escaping ([GameData]) -> Void){
        
        loader.loadWords { questions in
            
            guard questions.count >  roundCount else {
                completion(questions.map{.init(question: $0.originalWord, answer: $0.translatedWord, isCorrect: true, duration: roundDuration)})
                return
            }
            
            
            let roundsQuestion = questions.shuffled().prefix(roundCount)
            let correctPairsCount = Int(Double(roundCount) * 0.25)
            let correctPairs = roundsQuestion.shuffled().prefix(correctPairsCount).map{
                GameData(question: $0.originalWord, answer: $0.translatedWord, isCorrect: true, duration: roundDuration)
            }
            
            let remainingQuestions = roundsQuestion.suffix(roundsQuestion.count - correctPairsCount)
            let randomAnswers = remainingQuestions.map{$0.translatedWord}.shuffled()
            
            let incorrectPairs = remainingQuestions.map{ pair -> GameData in
                let answer = randomAnswers.randomElement() ?? pair.translatedWord
                return GameData(question: pair.originalWord, answer: answer, isCorrect: answer == pair.translatedWord, duration: roundDuration)
             }

            completion((correctPairs + incorrectPairs).shuffled())
        }
    }
}
