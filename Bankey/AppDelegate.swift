//
//  AppDelegate.swift
//  Bankey
//
//  Created by Ranjit Mahto on 07/09/23.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    var loginViewController = LoginViewController()
    var onboardingContainerVC = OnBoardingContainerVC()
    var mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        //window?.rootViewController = loginViewController
        loginViewController.delegate = self
        onboardingContainerVC.delegate = self
        
        mainViewController.setStatusBar()
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = appColor
        
        registerForNotification()
        
        window?.rootViewController = loginViewController
        
        mainViewController.selectedIndex = 0
        
        return true
    }
}

extension AppDelegate {
    
    private func registerForNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(didLogOutBankey),
                                               name: .logout,
                                               object: nil)
        
    }
    
    func setRootViewController(_ vc:UIViewController, animated:Bool = true) {
        
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with:window,
                          duration:0.5,
                          options:.transitionCrossDissolve,
                          animations:nil,
                          completion:nil)
        
    }
    
}

extension AppDelegate {
   @objc func didLogOutBankey() {
        setRootViewController(loginViewController)
    }
}


extension AppDelegate : LoginViewControllerDelegate {
    func didLogin() {
        
        if LocalState.hasOnBoarded {
            setRootViewController(mainViewController)
        }else{
            setRootViewController(onboardingContainerVC)
        }
    }
}

extension AppDelegate : OnBoardingContainerVCDelgate {
    func didFinishOnBoarding() {
        LocalState.hasOnBoarded = true
        setRootViewController(mainViewController)
    }
}

extension AppDelegate : LogoutDelegate {
    func didLogOut() {
        setRootViewController(loginViewController)
    }
}

