//
//  GameFlow.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 25/7/2022.
//

import UIKit

final class GameFlow {
    
    private let navigationController: UINavigationController
    private let loader: WordListLoader
    
    init(navigationController: UINavigationController, loader: WordListLoader){
        self.navigationController = navigationController
        self.loader = loader
    }
    
    func start() {
        let gameVc = GameUIComposer.compose(with: loader)
        gameVc.finish = showResult
        navigationController.viewControllers = [gameVc]
    }
    
    private func showResult(result: GameResult) {
        let viewModel = ResultViewModel(correctAttempts: result.correctAttempts, incorrectAttempts: result.incorrectAttempts, startNewGame: restartGame)
        let vc = ResultViewController(viewModel: viewModel)
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    private func restartGame() {
        navigationController.dismiss(animated: true, completion: nil)
     }
}
