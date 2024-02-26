//
//  UItextField+SecureToggle.swift
//  Bankey
//
//  Created by Ranjit Mahto on 16/09/23.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
    
    func enablePasswordToggle(){
        
        passwordToggleButton.setImage(UIImage(systemName:"eye.fill"), for:.normal)
        passwordToggleButton.setImage(UIImage(systemName:"eye.slash.fill"), for:.selected)
        
        passwordToggleButton.addTarget(self, action: #selector(togglePassword), for:.touchUpInside)
        
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePassword(_ sender:Any) {
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}
