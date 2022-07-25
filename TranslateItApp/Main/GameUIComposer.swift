//
//  GameUIComposer.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 25/7/2022.
//

import UIKit

final class GameUIComposer {
    static func compose(with loader: WordListLoader) -> (viewModel: GameViewModel, viewController: GameViewController) {
        let provider = GameDataProvider(loader: loader)
        let viewModel = GameViewModel(gameDataProvider: provider,
                                      roundCount: Constants.Game.roundCount,
                                      roundDuration: Constants.Game.roundDuration)
        let gameVc = GameViewController(viewModel: viewModel)
        return (viewModel,gameVc)
    }
}
