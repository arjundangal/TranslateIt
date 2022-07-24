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
        let expectedGameData = GameData(question: testQuestions.first?.originalWord ?? "",
                                        answer: testQuestions.first?.translatedWord ?? "",
                                        isCorrect: true)
        
        expect(sut, toCompleteWithResult: .question(data: expectedGameData)) {
            sut.start()
        }

    }
    
    //MARK: - Helpers
    
    private func expect(_ sut : GameViewModel,  toCompleteWithResult expectedResult : GameState, when action : () -> Void, file : StaticString =  #filePath, line : UInt = #line){
        
        let exp = expectation(description: "Waiting for load to complete")
        
        sut.gameState = {[weak self] receivedResult in
            guard self != nil else {return}
            switch(receivedResult, expectedResult){
            case let (.question(data: receivedData), .question(data: expectedData)):
                XCTAssertEqual(receivedData, expectedData, file : file, line : line)
                
            default :
                XCTFail("Expected result \(expectedResult) got \(receivedResult)", file: file, line : line)
            }
            exp.fulfill()
        }
        action()
        
        wait(for : [exp], timeout: 1.0)
    }
    
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
