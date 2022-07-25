//
//  SceneDelegateTests.swift
//  TranslateItAppTests
//
//  Created by Arjun Dangal on 25/7/2022.
//

import XCTest
@testable import TranslateItApp

class SceneDelegateTests:  XCTestCase {
    
    func test_configureWindow_setsWindowAsKeyAndVisible() {
        let window = UIWindowSpy()
        let sut = SceneDelegate()
        sut.window = window
        
        sut.configureWindow()
        
        XCTAssertEqual(window.makeKeyAndVisibleCallCount, 1, "Expected to make window key and visible")
    }
    
   
    
    private class UIWindowSpy: UIWindow {
        var makeKeyAndVisibleCallCount = 0
        
        override func makeKeyAndVisible() {
            makeKeyAndVisibleCallCount = 1
        }
    }
 }

