//
//  ViewController.swift
//  Vought Showcase
//
//  Created by Burhanuddin Rampurawala on 06/08/24.
//

import UIKit

class MainViewController: UIViewController {
    
    private let showButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Carousel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints =  false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(showButton)
        congigureConstraint()
        showButton.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
    }
    
    private func congigureConstraint(){
        let showButtonConstraint = [
            showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showButton.heightAnchor.constraint(equalToConstant: 50),
            showButton.widthAnchor.constraint(equalToConstant: 200)
        ]
        
        NSLayoutConstraint.activate(showButtonConstraint)
    }
    
    @objc private func tapButton(_ sender: UIButton) {
        // Create a carousel item provider
        let carouselItemProvider = CarouselItemDataSourceProvider()
        
        // Create carouselViewController
        let carouselViewController = CarouselViewController(items: carouselItemProvider.items())
        
        carouselViewController.modalPresentationStyle = .fullScreen
        carouselViewController.modalTransitionStyle = .coverVertical
        present(carouselViewController, animated: true)
        
    }
    
}

