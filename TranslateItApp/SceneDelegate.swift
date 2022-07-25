//
//  SceneDelegate.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowSecene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowSecene)
        let wordsURL = URL(fileURLWithPath:  Bundle.main.path(forResource: "words", ofType: "json")!)
        let loader = LocalWordsLoader(url: wordsURL)
        let provider = GameDataProvider(loader: loader)
        let viewModel = GameViewModel(gameDataProvider: provider, roundCount: 15, timeLimit: 5)
        let gameVc = GameViewController(viewModel: viewModel)
       
        window?.rootViewController = ResultViewController()
        window?.makeKeyAndVisible()
    }
 
}

