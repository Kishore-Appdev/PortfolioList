//
//  HodlingsSummaryView.swift
//  Portfolio
//
//  Created by Kishore B on 18/11/24.
//
import UIKit

class HoldingsSummaryView: UIView {
    
    private var isExpanded = false
    
    private var collapsibleViewHeightConstraint: NSLayoutConstraint!
    public var  isExpandedDelegate:((Bool)->Void)?
    private let currentValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Current value*"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    private let currentValueAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "₹27,893.65"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .right
        return label
    }()
    
    private let totalInvestmentLabel: UILabel = {
        let label = UILabel()
        label.text = "Total investment*"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    private let totalInvestmentAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "₹28,590.71"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .right
        return label
    }()
    private let todaysProfitLossLabel: UILabel = {
        let label = UILabel()
        label.text = "Today's Profit & Loss*"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    private let todaysProfitLossAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "₹28,590.71"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let profitLossButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Profit & Loss* ▼", for: .normal) // Arrow indicates collapsible
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let profitLossAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "-₹697.06 (2.44%)"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .red
        label.textAlignment = .right
        return label
    }()
    
    public let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let collapsibleView: UIView = {
        let view = UIView()
        view.isHidden = true // Initially collapsed
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        DispatchQueue.main.async {
            if let action = self.isExpandedDelegate{
                action(self.isExpanded)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        collapsibleView.addSubview(currentValueLabel)
        collapsibleView.addSubview(currentValueAmountLabel)
        collapsibleView.addSubview(totalInvestmentLabel)
        collapsibleView.addSubview(totalInvestmentAmountLabel)
        collapsibleView.addSubview(todaysProfitLossLabel)
        collapsibleView.addSubview(todaysProfitLossAmountLabel)
        addSubview(separatorView)
        addSubview(profitLossButton)
        addSubview(profitLossAmountLabel)
        addSubview(collapsibleView)
        self.backgroundColor = .systemGray6
        profitLossButton.addTarget(self, action: #selector(toggleCollapse), for: .touchUpInside)
        
    }
    
    public func configureAllSumValues(currentValue:Double,totalInvestment:Double,todaysProfitLoss:Double,profitAndLoss:Double){
        let profitLossPercentage = (profitAndLoss / totalInvestment) * 100
        currentValueAmountLabel.text = "₹\(String(format:"%.2f",currentValue))"
        totalInvestmentAmountLabel.text = "₹\(String(format:"%.2f",totalInvestment))"
        todaysProfitLossAmountLabel.text = "₹\(String(format:"%.2f",todaysProfitLoss))"
        profitLossAmountLabel.text = "₹\(String(format:"%.2f",profitAndLoss))(\(String(format:"%.2f",profitLossPercentage))%)"
        if profitAndLoss < 0{
            self.profitLossAmountLabel.textColor = .red
        }else{
            self.profitLossAmountLabel.textColor = UIColor.darkGreen
        }
        if todaysProfitLoss < 0{
            self.todaysProfitLossAmountLabel.textColor = .red
        }else{
            self.todaysProfitLossAmountLabel.textColor = UIColor.darkGreen
        }

        
    }
    
    private func setupConstraints() {
        currentValueLabel.translatesAutoresizingMaskIntoConstraints = false
        currentValueAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        totalInvestmentLabel.translatesAutoresizingMaskIntoConstraints = false
        totalInvestmentAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        todaysProfitLossLabel.translatesAutoresizingMaskIntoConstraints = false
        todaysProfitLossAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        profitLossButton.translatesAutoresizingMaskIntoConstraints = false
        profitLossAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        collapsibleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Separator view at the top
            separatorView.bottomAnchor.constraint(equalTo: profitLossButton.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            // Profit Loss Button
            profitLossButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            profitLossButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            profitLossButton.widthAnchor.constraint(equalToConstant: 200),
            profitLossButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            // Profit Loss Amount Label
            profitLossAmountLabel.centerYAnchor.constraint(equalTo: profitLossButton.centerYAnchor),
            profitLossAmountLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // Collapsible View
            collapsibleView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: 0),
            collapsibleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            collapsibleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        // Collapsible view height constraint
        collapsibleViewHeightConstraint = collapsibleView.heightAnchor.constraint(equalToConstant: 0)
        collapsibleViewHeightConstraint.isActive = true
        
        // Add constraints for collapsible content
        NSLayoutConstraint.activate([
            currentValueLabel.bottomAnchor.constraint(equalTo: totalInvestmentLabel.topAnchor, constant: -10),
            currentValueLabel.leadingAnchor.constraint(equalTo: collapsibleView.leadingAnchor),
            
            currentValueAmountLabel.centerYAnchor.constraint(equalTo: currentValueLabel.centerYAnchor),
            currentValueAmountLabel.trailingAnchor.constraint(equalTo: collapsibleView.trailingAnchor),
            
            totalInvestmentLabel.bottomAnchor.constraint(equalTo: todaysProfitLossLabel.topAnchor, constant: -10),
            totalInvestmentLabel.leadingAnchor.constraint(equalTo: collapsibleView.leadingAnchor),
            
            totalInvestmentAmountLabel.centerYAnchor.constraint(equalTo: totalInvestmentLabel.centerYAnchor),
            totalInvestmentAmountLabel.trailingAnchor.constraint(equalTo: collapsibleView.trailingAnchor),
            
            todaysProfitLossLabel.topAnchor.constraint(equalTo: totalInvestmentLabel.bottomAnchor, constant: 10),
            todaysProfitLossLabel.leadingAnchor.constraint(equalTo: collapsibleView.leadingAnchor),
            
            todaysProfitLossAmountLabel.centerYAnchor.constraint(equalTo: todaysProfitLossLabel.centerYAnchor),
            todaysProfitLossAmountLabel.trailingAnchor.constraint(equalTo: collapsibleView.trailingAnchor),
            todaysProfitLossAmountLabel.bottomAnchor.constraint(equalTo: collapsibleView.bottomAnchor)
        ])
    }
    
    @objc private func toggleCollapse() {
        isExpanded.toggle()
        collapsibleView.isHidden = !isExpanded
        collapsibleViewHeightConstraint.constant = isExpanded ? 120 : 0 // Adjust height as needed
        UIView.animate(withDuration: 0.3) {
            self.profitLossButton.setTitle(self.isExpanded ? "Profit & Loss* ▲" : "Profit & Loss* ▼", for: .normal)
            self.layoutIfNeeded()
        }
        if let action = self.isExpandedDelegate{
            action(isExpanded)
        }
    }
}

