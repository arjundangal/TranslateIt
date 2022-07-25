//
//  ViewController.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

import RxSwift
import UIKit

final class GameViewController: UIViewController {
    
    let titleLabel: UILabel =  {
        let label = UILabel()
        label.text = "Is this correct translation?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    let questionLabel: UILabel =  {
        let label = UILabel()
        label.text = "Question"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let answerLabel: UILabel =  {
        let label = UILabel()
        label.text = "Answer"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let correctCounterLabel: UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    let incorrectCounterLabel: UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    let correctBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Correct", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(UIColor.blue.withAlphaComponent(0.5), for: .highlighted)
        return button
    }()
    
    let incorrectBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Incorrect", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(UIColor.blue.withAlphaComponent(0.5), for: .highlighted)
        return button
    }()
    private lazy var buttonsStackView = UIStackView(arrangedSubviews: [correctBtn,incorrectBtn])

    private var viewModel: GameViewModel?
    public var finish: ((GameResult) -> Void)?
    private var answerLabelTopConstraint: NSLayoutConstraint?

    private let disposeBag = DisposeBag()
    
    convenience init(viewModel: GameViewModel){
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        bindViewModel()
        
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        
        DispatchQueue.main.async {
            viewModel.input.startGameCommand.onNext(())
        }
        
        correctBtn.rx.tap.map{_ in true}.bind(to: viewModel.input.attemptAnswer).disposed(by: disposeBag)
        incorrectBtn.rx.tap.map{_ in false}.bind(to: viewModel.input.attemptAnswer).disposed(by: disposeBag)
        
        viewModel.output.gameState.observe(on: MainScheduler.instance).subscribe(onNext: {[weak self] (state) in
            guard let self = self else {return}
            switch state {
            case .question(let gameData):
                self.questionLabel.text = gameData.question
                self.answerLabel.text = gameData.answer
                self.animateAnswer(duration: gameData.duration)
            case .ended(let result):
                self.finish?(result)
            }
        }).disposed(by: disposeBag)
        
        viewModel.output.correctCounter.subscribe(onNext: {[weak self] (counter) in
            guard let self = self else {return}
            self.correctCounterLabel.text = counter
        }).disposed(by: disposeBag)
        
        viewModel.output.incorrectCounter.subscribe(onNext: {[weak self] (counter) in
            guard let self = self else {return}
            self.incorrectCounterLabel.text = counter
        }).disposed(by: disposeBag)
        
    }
    
    private func animateAnswer(duration: Double) {
        answerLabel.layer.removeAllAnimations()
        answerLabelTopConstraint?.constant = 0
        view.layoutIfNeeded()
        let distance = answerLabel.frame.origin.y - buttonsStackView.frame.origin.y
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: []) {
            self.answerLabelTopConstraint?.constant = -distance
            self.view.layoutIfNeeded()
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                self.answerLabel.alpha = 1
            })
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
                self.answerLabel.alpha = 0
            })

        }

    }
    
    private func setupViews() {
        view.addSubview(correctCounterLabel)
        view.addSubview(incorrectCounterLabel)
        view.addSubview(titleLabel)
        view.addSubview(questionLabel)
        view.addSubview(answerLabel)
        view.addSubview(correctBtn)
        view.addSubview(incorrectBtn)
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 16
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            correctCounterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            correctCounterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            correctCounterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            incorrectCounterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            incorrectCounterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            incorrectCounterLabel.topAnchor.constraint(equalTo: correctCounterLabel.bottomAnchor, constant: 0),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: incorrectCounterLabel.bottomAnchor, constant: 30),
            
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            questionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            
            answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
        answerLabelTopConstraint = answerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 0)
        answerLabelTopConstraint?.isActive = true

        
    }
    
}

