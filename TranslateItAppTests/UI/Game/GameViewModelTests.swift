//
//  GameViewModelTests.swift
//  TranslateItAppTests
//
//  Created by Arjun Dangal on 24/7/2022.
//

import XCTest
import RxSwift
import RxTest
@testable import TranslateItApp

class GameViewModelTests: XCTestCase {
 
    
    func test_init_showsFirstQuestion() {
       
        let testQuestions = makeSampleQuestions()
        let (sut, scheduler, disposeBag) = makeSUT(questions: testQuestions)
        let expectedGameData = GameData(question: testQuestions.first?.originalWord ?? "",
                                        answer: testQuestions.first?.translatedWord ?? "",
                                        isCorrect: true)
 
        let expected = scheduler.createObserver(GameState.self)
        sut.output.gameState.bind(to: expected).disposed(by: disposeBag)
        
        sut.input.startGameCommand.onNext(())
        
        XCTAssertEqual(expected.events, [.init(time: 0, value: .next(GameState.question(data: expectedGameData)))])
 
    }
    
    
    
    
    //MARK: - Helpers
     private func makeSUT(questions: WordList) -> (GameViewModel,TestScheduler,DisposeBag) {
        let loader = LoaderSpy(questions: questions)
        let provider = GameDataProvider(loader: loader)
        let sut = GameViewModel(gameDataProvider: provider, roundCount: questions.count, timeLimit: 5)
         
         return (sut, TestScheduler(initialClock: 0), DisposeBag())
    }
    
    private let anyQuestion = WordPair(originalWord: "English", translatedWord: "Espanyol")
    
    private func makeSampleQuestions() -> [WordPair] {
        return [WordPair(originalWord: "English", translatedWord: "Espanyol"),
                WordPair(originalWord: "English1", translatedWord: "Espanyol1"),
                WordPair(originalWord: "English2", translatedWord: "Espanyol2")]
    }
    
    
   private class LoaderSpy: WordListLoader {
        
        private let questions: WordList
        
        init(questions: WordList) {
            self.questions = questions
        }
        
        func loadWords(completion: @escaping (WordList) -> Void) {
            completion(questions)
        }
        
        
    }
    
}
