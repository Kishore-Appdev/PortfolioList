//
//  HoldingsTableViewCell.swift
//  Portfolio
//
//  Created by Kishore B on 17/11/24.
//

import Foundation
import UIKit
class HoldingsTableViewCell:UITableViewCell{
    
    private let symbolLabel:UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 18)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    private let ltpTitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "LTP: "
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14, weight: .medium)

        return label
    }()
    private let ltpLabel:UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.textAlignment = .right

        return label
    }()
    private let netQuantityTitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "NET QTY: "
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    private let netQuantityLabel:UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    private let profitLossTitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "P&L: "
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    private let profitLossLabel:UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let bottomLineSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 1
        return view
    }()
    
    private let containerView:UIView = {
        let view = UIView()
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
            setupUi()
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func setupUi(){
        contentView.addSubview(containerView)
        containerView.addSubview(symbolLabel)
        containerView.addSubview(ltpTitleLabel)
        containerView.addSubview(ltpLabel)
        containerView.addSubview(profitLossTitleLabel)
        containerView.addSubview(profitLossLabel)
        containerView.addSubview(netQuantityTitleLabel)
        containerView.addSubview(netQuantityLabel)
        containerView.addSubview(bottomLineSeparator)
    }
    
    func setupConstraints(){
        containerView.translatesAutoresizingMaskIntoConstraints = false
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        ltpTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        ltpLabel.translatesAutoresizingMaskIntoConstraints = false
        profitLossTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        profitLossLabel.translatesAutoresizingMaskIntoConstraints = false
        netQuantityTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        netQuantityLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLineSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Symbol Label Constraints
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),

            symbolLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 12),
            symbolLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            symbolLabel.heightAnchor.constraint(equalToConstant: 30),

            ltpTitleLabel.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 0),
            ltpTitleLabel.centerYAnchor.constraint(equalTo: symbolLabel.centerYAnchor),
            ltpTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            ltpTitleLabel.widthAnchor.constraint(equalToConstant: 50), // Fixed width
            ltpTitleLabel.trailingAnchor.constraint(equalTo: ltpLabel.leadingAnchor, constant: -8),

            ltpLabel.centerYAnchor.constraint(equalTo: symbolLabel.centerYAnchor),
            ltpLabel.heightAnchor.constraint(equalToConstant: 30),
            ltpLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            netQuantityTitleLabel.leadingAnchor.constraint(equalTo: symbolLabel.leadingAnchor, constant: 0),
            netQuantityTitleLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 12),
            netQuantityTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            netQuantityTitleLabel.widthAnchor.constraint(equalToConstant: 65),
            
            netQuantityLabel.leadingAnchor.constraint(equalTo: netQuantityTitleLabel.trailingAnchor, constant: 8),
            netQuantityLabel.centerYAnchor.constraint(equalTo: netQuantityTitleLabel.centerYAnchor, constant: 0),
            netQuantityLabel.heightAnchor.constraint(equalToConstant: 30),
            
            profitLossTitleLabel.leadingAnchor.constraint(equalTo: netQuantityLabel.trailingAnchor, constant: 0),
            profitLossTitleLabel.centerYAnchor.constraint(equalTo: netQuantityTitleLabel.centerYAnchor, constant: 0),
            profitLossTitleLabel.widthAnchor.constraint(equalToConstant: 100),
            profitLossTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            profitLossLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            profitLossLabel.centerYAnchor.constraint(equalTo: netQuantityTitleLabel.centerYAnchor, constant: 0),
            profitLossLabel.heightAnchor.constraint(equalToConstant: 30),
            profitLossLabel.leadingAnchor.constraint(equalTo: profitLossTitleLabel.trailingAnchor, constant: 8),
            
            bottomLineSeparator.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            bottomLineSeparator.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            bottomLineSeparator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            bottomLineSeparator.heightAnchor.constraint(equalToConstant: 1)
            
            
            
            
        ])

        
    }
    
    func configure(holding:Holdings){
        self.symbolLabel.text = holding.symbol
        self.ltpLabel.text = "₹\(String(format:"%.2f",holding.ltp))"
        self.netQuantityLabel.text = "\(holding.quantity)"
        self.profitLossLabel.text = "₹\(String(format:"%.2f", holding.totalPNL))"
        if holding.totalPNL < 0 {
            self.profitLossLabel.textColor = .red
        }else{
            self.profitLossLabel.textColor = UIColor.darkGreen
        }
        
    }
    
    public static var identifier:String{
        return String(describing: self)
    }
    
    
}
