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
    private var viewModel:HoldingsViewModel!
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var holdingsSummaryView:HoldingsSummaryView!
    
    private var holdingsSummaryViewHeightConstraint:NSLayoutConstraint!
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
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let holdingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("HOLDINGS", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
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
        tableView.register(HoldingsTableViewCell.self, forCellReuseIdentifier: HoldingsTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Properties
    
    private var indicatorCenterXConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HoldingsViewModel()
        setupUI()
        setupConstraints()
        addActions()
        self.viewModel.refreshData = {
            self.tableView.reloadData()
            self.holdingsSummaryView.configureAllSumValues(currentValue: self.viewModel.currentValue, totalInvestment: self.viewModel.totalInvestment, todaysProfitLoss: self.viewModel.todaysPNL, profitAndLoss: self.viewModel.totalPNL)
        }
        self.holdingsSummaryView.isExpandedDelegate = {[weak self] isExpanded in
            if isExpanded {
                self?.holdingsSummaryViewHeightConstraint.constant = 150
                self?.holdingsSummaryView.separatorView.alpha = 1
            }else{
                self?.holdingsSummaryViewHeightConstraint.constant = 50
                self?.holdingsSummaryView.separatorView.alpha = 0
            }
            
        }
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.customBlue
        self.holdingsSummaryView = HoldingsSummaryView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Add buttons to stack view
        stackView.addArrangedSubview(positionsButton)
        stackView.addArrangedSubview(holdingsButton)
        
        // Add components to the container view
        containerView.addSubview(stackView)
        containerView.addSubview(separator)
        containerView.addSubview(indicatorView)
        containerView.addSubview(tableView)
        containerView.addSubview(holdingsSummaryView)
        containerView.bringSubviewToFront(holdingsSummaryView)
        // Add container view to the main view
        self.view.addSubview(containerView)
        self.holdingsSummaryView.layer.borderWidth = 1
        self.holdingsSummaryView.layer.cornerRadius = 8
        self.holdingsSummaryView.layer.borderColor = UIColor.gray.cgColor
    }

    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        holdingsSummaryView.translatesAutoresizingMaskIntoConstraints = false

        indicatorCenterXConstraint = indicatorView.centerXAnchor.constraint(equalTo: holdingsButton.centerXAnchor)
        
        NSLayoutConstraint.activate([
            // Container view constraints
            containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            // Stack view constraints
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            // Separator constraints
            separator.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            separator.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            // Indicator constraints
            indicatorView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 2),
            indicatorView.widthAnchor.constraint(equalToConstant: 110),
            indicatorCenterXConstraint!,
            
            tableView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: holdingsSummaryView.topAnchor, constant: -5),
            
            holdingsSummaryView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            holdingsSummaryView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            holdingsSummaryView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            
        ])
        holdingsSummaryViewHeightConstraint = holdingsSummaryView.heightAnchor.constraint(equalToConstant: 500)
        holdingsSummaryViewHeightConstraint.isActive = true
    }
    
    private func addActions() {
        positionsButton.addTarget(self, action: #selector(holdingsTapped), for: .touchUpInside)
        holdingsButton.addTarget(self, action: #selector(positionsTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func holdingsTapped() {
        moveIndicator(to: positionsButton)
    }
    
    @objc private func positionsTapped() {
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

extension HoldingsViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.holdingsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HoldingsTableViewCell.identifier, for: indexPath) as! HoldingsTableViewCell
        cell.configure(holding: viewModel.holdingsData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
}
