//
//  DummyViewController.swift
//  Bankey
//
//  Created by Ranjit Mahto on 14/09/23.
//

import UIKit

class DummyViewController: UIViewController {

    let stackview = UIStackView()
    let lable = UILabel()
    let logOutButton = UIButton(type: .system)
    
    weak var logoutDeledate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension DummyViewController {
    
    private func style(){
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 20
        
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.preferredFont(forTextStyle:.title1)
        lable.text = "Welcome"
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.setTitle("Logout", for: [])
        logOutButton.addTarget(self, action: #selector(tappedLogOut), for:.primaryActionTriggered)
    }
    
    private func layout(){
        
        view.addSubview(stackview)
        stackview.addArrangedSubview(lable)
        stackview.addArrangedSubview(logOutButton)
        
        NSLayoutConstraint.activate([
            stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}

// MARK: Actions
extension DummyViewController{
    
    @objc func tappedLogOut(_ sender:UIButton){
        print("logout tapped")
        logoutDeledate?.didLogOut()
    }
}
