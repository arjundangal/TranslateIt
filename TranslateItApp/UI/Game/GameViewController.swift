//
//  ViewController.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

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
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    let incorrectCounterLabel: UILabel =  {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    let correctBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Correct", for: .normal)
        button.setTitleColor(.black, for: .normal)
         return button
    }()
    
    let incorrectBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Incorrect", for: .normal)
        button.setTitleColor(.black, for: .normal)
         return button
    }()
    
    private var gameEngine: GameViewModel?
    
    convenience init(gameEngine: GameViewModel){
        self.init()
        self.gameEngine = gameEngine
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        startGame()
        incorrectBtn.addTarget(self, action: #selector(incorrectBtnTapped), for: .touchUpInside)
        correctBtn.addTarget(self, action: #selector(correctBtnTapped), for: .touchUpInside)
     }
    
    private func startGame() {
        guard let gameEngine = gameEngine else {
            return
        }
        
        gameEngine.correctAnswers = {[weak self] correctAnswers in
            self?.correctCounterLabel.text = correctAnswers
        }
        
        gameEngine.incorrectAnswers = {[weak self] incorrectAnswers in
            self?.incorrectCounterLabel.text = incorrectAnswers
        }
        
        gameEngine.gameState = {[weak self]  state in
            guard let self = self else {return}
            switch state {
            case .question(let pair):
                self.questionLabel.text = pair.question
                self.answerLabel.text = pair.answer
             }
        }
        gameEngine.start()
 
     }
    
    @objc private func incorrectBtnTapped() {
        gameEngine?.answer(isCorrect: false)
    }
    
    @objc private func correctBtnTapped() {
        gameEngine?.answer(isCorrect: true)
    }
    
    
    private func setupViews() {
        view.addSubview(correctCounterLabel)
        view.addSubview(incorrectCounterLabel)
        view.addSubview(titleLabel)
        view.addSubview(questionLabel)
        view.addSubview(answerLabel)
        view.addSubview(correctBtn)
        view.addSubview(incorrectBtn)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [correctBtn,incorrectBtn])
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
            answerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
}

