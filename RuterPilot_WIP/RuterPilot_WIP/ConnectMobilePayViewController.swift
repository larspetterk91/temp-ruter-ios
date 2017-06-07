//
//  ConnectMobilePayViewController.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 26/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import UIKit

class ConnectMobilePayViewController: UIViewController {

    @IBOutlet var connectButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectButton.layer.cornerRadius = 5
        connectButton.layer.borderWidth = 1
        connectButton.layer.borderColor = UIColor(red: 15, green: 110, blue: 177).cgColor
    }
    
    @IBAction func connectTouchUpInside(_ sender: UIButton) {
        // Connect to MobilePay somehow
        
        // then link back to next page
        let successMobilePayViewController = SuccessMobilePayViewController()
        self.navigationController?.pushViewController(successMobilePayViewController, animated: true)
    }
}
