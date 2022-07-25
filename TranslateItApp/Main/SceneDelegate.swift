//
//  SceneDelegate.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

import UIKit
import RxRelay

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    lazy var wordsURL = URL(fileURLWithPath:  Bundle.main.path(forResource: "words", ofType: "json")!)
    lazy var loader = LocalWordsLoader(url: wordsURL)
    
    lazy var navigationController = UINavigationController()
    
    
    lazy var gameFlow = GameFlow(navigationController: navigationController, loader: loader)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowSecene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowSecene)
        window?.rootViewController = navigationController
        navigationController.isNavigationBarHidden = true
        window?.makeKeyAndVisible()
        
        gameFlow.start()
    }
 
}

class GameUIComposer {
    static func compose(with loader: WordListLoader) -> GameViewController {
        let provider = GameDataProvider(loader: loader)
        let viewModel = GameViewModel(gameDataProvider: provider, roundCount: 15, timeLimit: 5)
        let gameVc = GameViewController(viewModel: viewModel)
        return gameVc
    }
}
 
