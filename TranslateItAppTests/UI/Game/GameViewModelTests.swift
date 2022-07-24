//
//  GameViewModelTests.swift
//  TranslateItAppTests
//
//  Created by Arjun Dangal on 24/7/2022.
//

import XCTest
@testable import TranslateItApp

class GameViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_init_showsFirstQuestion() {
        
        let testQuestions = WordPair(originalWord: "English", translatedWord: "Espanyol")
        let loader = LoaderSpy(wordList: [testQuestions])
        let provider = GameDataProvider(loader: loader)
        let sut = GameViewModel(gameDataProvider: provider, totalRounds: 1)
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
 
        XCTAssertEqual(testQuestions.originalWord, result?.question)
        XCTAssertEqual(testQuestions.translatedWord, result?.answer)
        
    }
 
    //MARK: - Helpers
    
   
    
    class LoaderSpy: WordListLoader {

        private let wordList: WordList
        
        init(wordList: WordList) {
            self.wordList = wordList
        }
 
        func loadWords(completion: @escaping (WordList) -> Void) {
            completion(wordList)
        }
        
        
    }

}
