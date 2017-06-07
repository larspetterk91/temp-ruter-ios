//
//  OnboardBluetoothViewController.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 29/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import UIKit

class OnboardBluetoothViewController: UIViewController {

    @IBOutlet var bluetoothOnButton: UIButton!
    @IBOutlet var turnOnBluetoothLaterButton: UIButton!
    
    let utils = Utils()
    
    let yourAttributes : [String: Any] = [
        NSFontAttributeName : UIFont.systemFont(ofSize: 14),
        NSForegroundColorAttributeName : UIColor(red: 15, green: 110, blue: 177),
        NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue]
    //.styleDouble.rawValue, .styleThick.rawValue, .styleNone.rawValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bluetoothOnButton.layer.cornerRadius = 5
        bluetoothOnButton.layer.borderWidth = 1
        bluetoothOnButton.layer.borderColor = UIColor(red: 15, green: 110, blue: 177).cgColor
        
        let attributeString = NSMutableAttributedString(string: "Jeg vil slå på blåtann senere",
                                                        attributes: yourAttributes)
        turnOnBluetoothLaterButton.setAttributedTitle(attributeString, for: .normal)
    }
    
    @IBAction func bluetoothOn(_ sender: UIButton) {
        // Turn on bluetooth somehow
        
        // set onboarding completed
        utils.setUserDefault(key: "onboardingCompleted", value: true as AnyObject)
        
        // Go to app
        
        // Define identifier
        let notifyDidLogin = Notification.Name("DidLogin")
        let notifyExitFullscreen = Notification.Name("ExitFullScreen")
        
        // Post notification
        NotificationCenter.default.post(name: notifyExitFullscreen, object: nil)
        NotificationCenter.default.post(name: notifyDidLogin, object: nil)
    }
    
    @IBAction func turnOnBluetoothLaterButton(_ sender: UIButton) {
        // go to app
        
    }
}
