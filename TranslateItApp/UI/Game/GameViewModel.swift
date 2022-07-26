//
//  GameViewModel.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

import RxSwift
import RxCocoa

final class GameViewModel {
    
    let input: Input
    let output: Output
    
    struct Input {
        let startGameCommand: AnyObserver<Void>
        let attemptAnswer: AnyObserver<Bool?>
    }
    
    struct Output {
        let gameState: Observable<GameState>
        let correctCounter: Observable<String>
        let incorrectCounter: Observable<String>
    }

    init(gameDataProvider: GameDataProvider, timerProvider: Timer.Type, roundCount: Int, roundDuration: Double){

        var currentQuestionIndex = -1
        
        let startGameCommand = PublishSubject<Void>()
        let attemptAnswer = PublishSubject<Bool?>()
        let correctAttempts = BehaviorRelay<Int>(value: 0)
        let incorrectAttempts = BehaviorRelay<Int>(value: 0)
        
        let gameCommands = Observable.merge(startGameCommand.map{_ in nil},attemptAnswer)
        
        var timer: Timer?
        
        let roundData = startGameCommand.flatMapLatest{ () -> Observable<[GameData]> in 
            currentQuestionIndex = -1
            correctAttempts.accept(0)
            incorrectAttempts.accept(0)
            return GameViewModel.makeRoundsData(from: gameDataProvider,
            roundCount: roundCount,
            roundDuration: roundDuration)
        }
        
        let gameState = gameCommands.withLatestFrom(roundData){answer, gameData in return (answer, gameData)}.flatMapLatest { answer,gameData -> Observable<GameState> in
            if currentQuestionIndex != -1 && currentQuestionIndex < gameData.count{
                if answer == nil || answer != gameData[currentQuestionIndex].isCorrect {
                    incorrectAttempts.accept(incorrectAttempts.value + 1)
                }else {
                    correctAttempts.accept(correctAttempts.value + 1)
                }
            }
            
            currentQuestionIndex += 1
            if incorrectAttempts.value < 3 &&  currentQuestionIndex < gameData.count {
                   var elapsedSeconds = 0
                    if timer == nil {
                        timer = timerProvider.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
                             if elapsedSeconds > Int(roundDuration) - 1 {
                                 attemptAnswer.onNext(nil)
                                 elapsedSeconds = 0
                             }else {
                                 elapsedSeconds += 1
                             }
                         })
                    }
                    return Observable.just(GameState.question(data: gameData[currentQuestionIndex]))
                    
                }else {
                    timer?.invalidate()
                    timer = nil
                    return .just(.ended(result: .init(correctAttempts: correctAttempts.value, incorrectAttempts: incorrectAttempts.value)))
                }
            
 
        }
        
        let correctCounter = correctAttempts.asObservable().flatMapLatest{
           Observable.just("Correct: \($0)")
        }
        
        let incorrectCounter = incorrectAttempts.asObservable().flatMapLatest{
            Observable.just("Incorrect: \($0)")
        }
        
        
        
        self.input = Input(startGameCommand: startGameCommand.asObserver(),
                           attemptAnswer: attemptAnswer.asObserver())
        
        self.output = Output(gameState: gameState,
                             correctCounter: correctCounter,
                             incorrectCounter: incorrectCounter)
        
    }
    
    static func makeRoundsData(from provider: GameDataProvider, roundCount: Int, roundDuration: Double) -> Observable<[GameData]> {
        return Observable<[GameData]>.create { observer in
            
            provider.makeData(roundCount: roundCount, roundDuration: roundDuration) { data in
                observer.onNext(data)
            }
            return Disposables.create {
                
            }
        }
    }
 
}
 
