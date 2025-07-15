//
//  IntermediateViewController.swift
//  Vought Showcase
//
//  Created by Rishav chandra on 15/07/25.
//

import UIKit

class IntermediateViewController: UIViewController {
    
    private let showButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Carousel", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .white
        button.translatesAutoresizingMaskIntoConstraints = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(showButton)
        congigureConstraint()
    }
    
    
    private func congigureConstraint(){
        let showButtonConstraint = [
            showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showButton.heightAnchor.constraint(equalToConstant: 50),
            showButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(showButtonConstraint)
    }

}
