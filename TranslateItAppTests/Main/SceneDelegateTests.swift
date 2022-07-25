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
    
    func test_configureWindow_configuresNavigationController() {
        let sut = SceneDelegate()
        sut.window = UIWindowSpy()

        sut.configureWindow()

        let rootViewController = sut.window?.rootViewController
 
        XCTAssertTrue(rootViewController is UINavigationController, "Expected root as \(UINavigationController.self), got \(String(describing: rootViewController)) instead")
    }
    
    func test_startGameFlow_setsGameViewControllerAsTopViewController() {
        let sut = SceneDelegate()
        sut.window = UIWindowSpy()

        sut.configureWindow()
        sut.startGameFlow()

        let rootViewController = sut.window?.rootViewController as? UINavigationController
 
        XCTAssertTrue(rootViewController?.topViewController is GameViewController, "Expected root as \(GameViewController.self), got \(String(describing: rootViewController)) instead")
    }
    
    
    private class UIWindowSpy: UIWindow {
        var makeKeyAndVisibleCallCount = 0
        
        override func makeKeyAndVisible() {
            makeKeyAndVisibleCallCount = 1
        }
    }
 }

