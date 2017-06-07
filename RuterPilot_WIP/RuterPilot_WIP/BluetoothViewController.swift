//
//  BluetoothViewController.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 29/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import UIKit

class BluetoothViewController: UIViewController {

    @IBOutlet var onBluetoothButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    
    let yourAttributes : [String: Any] = [
        NSFontAttributeName : UIFont.systemFont(ofSize: 14),
        NSForegroundColorAttributeName : UIColor(red: 15, green: 110, blue: 177),
        NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController {
            navigationController.isNavigationBarHidden = true
        }
        
        onBluetoothButton.layer.cornerRadius = 5
        onBluetoothButton.layer.borderWidth = 1
        onBluetoothButton.layer.borderColor = UIColor(red: 15, green: 110, blue: 177).cgColor
        
        let attributeString = NSMutableAttributedString(string: "Lukk",
                                                        attributes: yourAttributes)
        closeButton.setAttributedTitle(attributeString, for: .normal)
        
    }
    
    @IBAction func onBluetoothTouchUpInside(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string:"App-Prefs:root=Bluetooth")!, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func closeTouchUpInside(_ sender: UIButton) {
        
    }
}
