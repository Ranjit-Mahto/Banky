//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Ranjit Mahto on 15/09/23.
//

import Foundation
import UIKit

class AccountSummaryHeaderView : UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let shakeyBellView = ShakeyBellView()
    
    struct ViewModel {
        let welcomeMessage: String
        let name: String
        let date: Date
        
        var dateFormatted: String {
            return date.monthDayYearString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func commonInit(){

        let bundle = Bundle(for:AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = appColor
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo:self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo:self.trailingAnchor).isActive = true
        
        setUpShakeyBellView()
    }
    
    private func setUpShakeyBellView(){
        shakeyBellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shakeyBellView)
        
        NSLayoutConstraint.activate([
            shakeyBellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            shakeyBellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configure(viewModel:ViewModel) {
        welcomeLabel.text = viewModel.welcomeMessage
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.dateFormatted
    }
    
}
