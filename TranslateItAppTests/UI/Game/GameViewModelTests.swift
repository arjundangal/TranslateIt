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
 
        let expectedState = scheduler.createObserver(GameState.self)
        sut.output.gameState.bind(to: expectedState).disposed(by: disposeBag)
        
        sut.input.startGameCommand.onNext(())
        
        XCTAssertEqual(expectedState.events, [.init(time: 0, value: .next(GameState.question(data: expectedGameData)))])
 
    }
    
    
    func test_showsSecondQuestions_whenFirstQuestionIsAttempted() {
        let testQuestions = makeSampleQuestions()
        let (sut, scheduler, disposeBag) = makeSUT(questions: testQuestions)
        let expectedGameData = GameData(question: testQuestions[1].originalWord ,
                                        answer: testQuestions[1].translatedWord ,
                                        isCorrect: true)
        let expectedState = scheduler.createObserver(GameState.self)
        sut.output.gameState.bind(to: expectedState).disposed(by: disposeBag)
        
        sut.input.startGameCommand.onNext(())
        sut.input.attemptAnswer.onNext(true)
        
        XCTAssertEqual(expectedState.events.last!, .init(time: 0, value:  .next(GameState.question(data: expectedGameData))))

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
