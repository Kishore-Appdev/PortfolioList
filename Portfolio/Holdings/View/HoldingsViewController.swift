//
//  FirstScreen.swift
//  Portfolio
//
//  Created by Kishore B on 17/11/24.
//

import Foundation
import UIKit

class HoldingsViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private let positionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("POSITONS", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let holdingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("HOLDINGS", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let tableView: UITableView = {
           let tableView = UITableView()
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
           return tableView
       }()
    
    // MARK: - Properties
    
    private var indicatorCenterXConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        addActions()
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.customBlue
        
        // Add buttons to stack view
        stackView.addArrangedSubview(positionsButton)
        stackView.addArrangedSubview(holdingsButton)
        
        // Add components to the container view
        containerView.addSubview(stackView)
        containerView.addSubview(separator)
        containerView.addSubview(indicatorView)
        
        // Add container view to the main view
        self.view.addSubview(containerView)
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        indicatorCenterXConstraint = indicatorView.centerXAnchor.constraint(equalTo: holdingsButton.centerXAnchor)
        
        NSLayoutConstraint.activate([
            // Container view constraints
            containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            // Stack view constraints
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            // Separator constraints
            separator.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            separator.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            // Indicator constraints
            indicatorView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 2),
            indicatorView.widthAnchor.constraint(equalTo: positionsButton.widthAnchor),
            indicatorCenterXConstraint!
        ])
    }
    
    private func addActions() {
        positionsButton.addTarget(self, action: #selector(holdingsTapped), for: .touchUpInside)
        holdingsButton.addTarget(self, action: #selector(positionsTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func holdingsTapped() {
        print("Holdings tab tapped")
        moveIndicator(to: positionsButton)
    }
    
    @objc private func positionsTapped() {
        print("Positions tab tapped")
        moveIndicator(to: holdingsButton)
    }
    
    // MARK: - Helper Methods
    
    private func moveIndicator(to button: UIButton) {
        indicatorCenterXConstraint?.isActive = false
        indicatorCenterXConstraint = indicatorView.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        indicatorCenterXConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
