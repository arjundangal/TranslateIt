//
//  ResultVIewController.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 25/7/2022.
//


import UIKit
import RxSwift
 
final class ResultViewController: UIViewController {
    
    let titleLabel: UILabel =  {
        let label = UILabel()
        label.text = "Final Results"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    let correctCounterLabel: UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    let incorrectCounterLabel: UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start New Game", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(UIColor.blue.withAlphaComponent(0.5), for: .highlighted)
        return button
    }()
    
    private var viewModel: ResultViewModel?
    private let disposeBag = DisposeBag()
    
    convenience init(viewModel: ResultViewModel) {
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
        correctCounterLabel.text = viewModel.correctAnswers
        incorrectCounterLabel.text = viewModel.incorrectAnswers
        startButton.rx.tap.bind(to: viewModel.startNewGame).disposed(by: disposeBag)
    }
    
    private func setupViews() {
        
        view.addSubview(titleLabel)
        view.addSubview(correctCounterLabel)
        view.addSubview(incorrectCounterLabel)
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            correctCounterLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            correctCounterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            correctCounterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            incorrectCounterLabel.topAnchor.constraint(equalTo: correctCounterLabel.bottomAnchor, constant: 10),
            incorrectCounterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            incorrectCounterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            
            startButton.topAnchor.constraint(equalTo: incorrectCounterLabel.bottomAnchor, constant: 40),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            
         ])
    }
    
}

