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
    
    private var viewModel: GameViewModel?
    
    let disposeBag = DisposeBag()
    
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
        
        viewModel.output.gameState.subscribe(onNext: {[weak self] (state) in
            guard let self = self else {return}
            switch state {
            case .question(let pair):
                self.questionLabel.text = pair.question
                self.answerLabel.text = pair.answer
            case .ended:
                self.questionLabel.text = ""
                self.answerLabel.text = ""
                self.correctBtn.isHidden = true
                self.incorrectBtn.isHidden = true
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

