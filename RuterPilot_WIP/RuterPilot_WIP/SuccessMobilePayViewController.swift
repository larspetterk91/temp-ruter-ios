//
//  SuccessMobilePayViewController.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 26/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import UIKit

class SuccessMobilePayViewController: UIViewController {

    @IBOutlet var approveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        approveButton.layer.cornerRadius = 5
        approveButton.layer.borderWidth = 1
        approveButton.layer.borderColor = UIColor(red: 15, green: 110, blue: 177).cgColor
    }
    
    @IBAction func approveTouchUpInside(_ sender: UIButton) {
        let setupAndDescripViewController = SetupAndDescripViewController()
        self.navigationController?.pushViewController(setupAndDescripViewController, animated: true)
    }
    
}
