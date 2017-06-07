//
//  Utils.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 29/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import Foundation
import UIKit

struct Utils {
    func setRoundedButtons(button: UIButton){
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 15, green: 110, blue: 177).cgColor
    }
    
    // MARK: User Default
    
    func setUserDefault(key: String, value: AnyObject){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    func getUserDefault(key: String)  -> AnyObject?{
        var returnValue: AnyObject?
        let defaults = UserDefaults.standard
        if let value : AnyObject = defaults.value(forKey: key) as AnyObject? {
            returnValue = value
        }
        return returnValue
    }
    
    func removeUserDefault(key: String){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}
