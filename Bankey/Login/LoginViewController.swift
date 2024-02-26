//
//  ViewController.swift
//  Bankey
//
//  Created by Ranjit Mahto on 07/09/23.
//

import UIKit

protocol LogoutDelegate: AnyObject{
    func didLogOut()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subtitleLablel = UILabel()

    let loginView = LoginView()
    let loginButton = UIButton(type: .system)
    let erroMsgLabel = UILabel()
    
    weak var delegate : LoginViewControllerDelegate?
    
    var userName : String? {
        return loginView.usernameTextField.text
    }
    
    var password : String? {
        return loginView.passwordTextField.text
    }
    
    //animation
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgerOffScreen : CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor : NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loginButton.configuration?.showsActivityIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
}

extension LoginViewController {
    
    private func style() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle:.largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Bankey"
        titleLabel.alpha = 0
        view.addSubview(titleLabel)
        
        subtitleLablel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLablel.textAlignment = .center
        subtitleLablel.font = UIFont.preferredFont(forTextStyle:.title3)
        subtitleLablel.adjustsFontForContentSizeCategory = true
        subtitleLablel.numberOfLines = 0
        subtitleLablel.alpha = 0
        subtitleLablel.text = "Your premium source for all things banking"
        view.addSubview(subtitleLablel)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.configuration = .filled()
        loginButton.configuration?.imagePadding = 8 //for indicator spacing
        loginButton.setTitle("Sign In", for:.normal)
        loginButton.addTarget(self, action: #selector(signInTapped), for:.touchUpInside)
        view.addSubview(loginButton)
        
        erroMsgLabel.translatesAutoresizingMaskIntoConstraints = false
        erroMsgLabel.textAlignment = .center
        erroMsgLabel.textColor = .systemRed
        erroMsgLabel.numberOfLines = 0
        erroMsgLabel.isHidden = true
        view.addSubview(erroMsgLabel)
    }
    
    private func layout() {
        
        //titile
        /*NSLayoutConstraint.activate([
            subtitleLablel.topAnchor.constraint(equalToSystemSpacingBelow:titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])*/
        
        //titile
        NSLayoutConstraint.activate([
            subtitleLablel.topAnchor.constraint(equalToSystemSpacingBelow:titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgerOffScreen)
        titleLeadingAnchor?.isActive = true
        
        //Subtitle
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLablel.bottomAnchor, multiplier: 3),
            //subtitleLablel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            subtitleLablel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        subtitleLeadingAnchor = subtitleLablel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgerOffScreen)
        subtitleLeadingAnchor?.isActive = true
        
        //login view
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier:1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        //loginbutton
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            loginButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        //erroMsgLabel
        NSLayoutConstraint.activate([
            erroMsgLabel.topAnchor.constraint(equalToSystemSpacingBelow: loginButton.bottomAnchor, multiplier: 2),
            erroMsgLabel.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            erroMsgLabel.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor)
        ])
    }
    
}

// MARK : Actions
extension LoginViewController {
    
    @objc func signInTapped(sender:UIButton){
        erroMsgLabel.isHidden = true
        login()
    }
    
    private func login(){
        
        guard let username = userName, let password = password else{
            assertionFailure("username and password should never be nil")
            return
        }
        
//        if username.isEmpty || password.isEmpty {
//          configureView(withMessage:"Username / password cannot be blank")
//            return
//        }
        
        if username == "" && password == "" {
            loginButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username and password!")
        }
    }
    
    private func configureView(withMessage message:String){
        erroMsgLabel.isHidden = false
        erroMsgLabel.text = message
        shakeButton()
    }
}

//MARK: Animations
extension LoginViewController {
    
    private func animate(){
        
        let duration = 0.8
        let afterDelay = 0.25
        
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay:afterDelay)
        
        let animator3 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.titleLabel.alpha = 1
            self.subtitleLablel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay:afterDelay)
        
        let animator4 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.subtitleLablel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator4.startAnimation(afterDelay:afterDelay)
    }
    
    private func shakeButton(){
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        loginButton.layer.add(animation, forKey:"shake")
    }
}


