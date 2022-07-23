//
//  ViewController.swift
//  TranslateItApp
//
//  Created by Arjun Dangal on 23/7/2022.
//

import UIKit

class GameViewController: UIViewController {
   
    let titleLabel: UILabel =  {
        let label = UILabel()
        label.text = "Is this correct translation?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
     }
    
    func setupViews() {
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
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),

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

