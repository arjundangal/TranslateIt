//
//  GameViewModelTests.swift
//  TranslateItAppTests
//
//  Created by Arjun Dangal on 24/7/2022.
//

import XCTest
@testable import TranslateItApp

class GameViewModelTests: XCTestCase {

    func test_init_showsFirstQuestion() {
        let testQuestions = makeSampleQuestions()
        let sut = makeSUT(questions: testQuestions)
       
        let expectation = expectation(description: "Waiting for completion")
        var result: GameData?

        sut.gameState = { state in
            switch state {
            case .question(let data):
                result = data
                expectation.fulfill()
            case .ended:
                break
            }
        }

        sut.start()
        
        wait(for: [expectation], timeout: 1.0)
 
        XCTAssertEqual(testQuestions.first?.originalWord, result?.question)
        XCTAssertEqual(testQuestions.first?.translatedWord, result?.answer)
        
    }
 
    //MARK: - Helpers
    
    private func makeSUT(questions: WordList) -> GameViewModel {
        let loader = LoaderSpy(questions: questions)
        let provider = GameDataProvider(loader: loader)
        let sut = GameViewModel(gameDataProvider: provider, totalRounds: questions.count)
        return sut
    }
    
    private let anyQuestion = WordPair(originalWord: "English", translatedWord: "Espanyol")

    private func makeSampleQuestions() -> [WordPair] {
        return [WordPair(originalWord: "English", translatedWord: "Espanyol"),
                WordPair(originalWord: "English1", translatedWord: "Espanyol1"),
                WordPair(originalWord: "English2", translatedWord: "Espanyol2")]
    }
   
    
    class LoaderSpy: WordListLoader {

        private let questions: WordList
        
        init(questions: WordList) {
            self.questions = questions
        }
 
        func loadWords(completion: @escaping (WordList) -> Void) {
            completion(questions)
        }
        
        
    }

}
