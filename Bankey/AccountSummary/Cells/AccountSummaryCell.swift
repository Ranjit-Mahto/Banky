//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Ranjit Mahto on 15/09/23.
//

import Foundation
import UIKit

enum AccountType: String, Codable {
    case Banking
    case CreditCard
    case Investment
}

class AccountSummaryCell : UITableViewCell {
    
    struct ViewModel {
        let accountType : AccountType
        let accountName : String
        let balance : Decimal
        
        var balanceAsAttributedString: NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    
    let typeLabel = UILabel()
    let barView = UIView()
    let nameLabel = UILabel()
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balaceAmountLabel = UILabel()
    let chevronImageView = UIImageView()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AccountSummaryCell {
    
    private func setUp(){
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle:.caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "typelabel"
        contentView.addSubview(typeLabel)
        
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.backgroundColor = appColor
        contentView.addSubview(barView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.text = "namelable"
        contentView.addSubview(nameLabel)
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle:.body)
        balanceLabel.textAlignment = .right
        balanceLabel.adjustsFontSizeToFitWidth = true
        balanceLabel.text = "Some balance"
        
        balaceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balaceAmountLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balaceAmountLabel.textAlignment = .right
        
        //balaceAmountLabel.text = "$929,345.93"
        balaceAmountLabel.attributedText = makeFormattedBalance(dollars: "929,466", cents: "23")
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0
        contentView.addSubview(balanceStackView)
        
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balaceAmountLabel)
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName:"chevron.right")!.withTintColor(appColor, renderingMode:.alwaysOriginal)
        chevronImageView.image = chevronImage
        contentView.addSubview(chevronImageView)
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier:2),
        ])
        
        NSLayoutConstraint.activate([
            barView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            barView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier:2),
            barView.heightAnchor.constraint(equalToConstant:4),
            barView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow:barView.bottomAnchor, multiplier:2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter:contentView.leadingAnchor, multiplier:2)
        ])
        
        NSLayoutConstraint.activate([
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: barView.bottomAnchor, multiplier:0),
            balanceStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4)
        ])
        
        NSLayoutConstraint.activate([
            chevronImageView.centerYAnchor.constraint(equalTo:contentView.centerYAnchor),
            //chevronImageView.leadingAnchor.constraint(equalTo: balanceStackView.trailingAnchor, constant: 16)
            trailingAnchor.constraint(equalToSystemSpacingAfter:chevronImageView.trailingAnchor, multiplier:1)
        ])
    }
}

extension AccountSummaryCell {
    
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
    
    func configure(with vm: ViewModel) {
        
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balaceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        switch vm.accountType {
            case .Banking:
                barView.backgroundColor = appColor
                balanceLabel.text = "Current balance"
            case .CreditCard:
                barView.backgroundColor = .systemOrange
                balanceLabel.text = "Balance"
            case .Investment:
                barView.backgroundColor = .systemPurple
                balanceLabel.text = "Value"
                
        }
    }
    
}

