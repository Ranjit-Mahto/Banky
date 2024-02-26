//
//  LocalState.swift
//  Bankey
//
//  Created by Ranjit Mahto on 14/09/23.
//

import Foundation

public class LocalState {
    
    private enum Keys: String {
        case hasOnBoarded
    }
    
    public static var hasOnBoarded : Bool {
        get {
            return UserDefaults.standard.bool(forKey:Keys.hasOnBoarded.rawValue)
        }
        set(newVlaue){
            UserDefaults.standard.set(newVlaue, forKey: Keys.hasOnBoarded.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
}
