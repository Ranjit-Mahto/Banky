//
//  UIViewController+Utils.swift
//  Bankey
//
//  Created by Ranjit Mahto on 15/09/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setStatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground() // to hide Navigation Bar Line also
        navBarAppearance.backgroundColor = appColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
//    func setStatusBar() {
//        let statusBarSize = UIApplication.shared.statusBarFrame.size
//        let fram = CGRect(origin: .zero, size: statusBarSize)
//        let statusBarView = UIView(frame: fram)
//
//        statusBarView.backgroundColor = appColor
//        view.addSubview(statusBarView)
//    }
    
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
