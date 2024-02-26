//
//  OnBoardingViewController.swift
//  Bankey
//
//  Created by Ranjit Mahto on 08/09/23.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    var imageName : String
    var descText : String

    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()
        // Do any additional setup after loading the view.
    }
    
    init(imageName:String, descText:String){
        self.imageName = imageName
        self.descText = descText
        super.init(nibName:nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OnBoardingViewController {
    
    func style(){
        
        view.backgroundColor = .systemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle:.title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = descText
        
    }
    
    func layout(){
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
        
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter:stackView.trailingAnchor, multiplier:1)
        ])
    }
    
}
