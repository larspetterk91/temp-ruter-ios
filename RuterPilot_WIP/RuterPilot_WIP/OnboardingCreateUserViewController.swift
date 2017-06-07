//
//  OnboardingCreateUserViewController.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 26/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import UIKit

class OnboardingCreateUserViewController: UIViewController {
    
    @IBOutlet var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 5
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor(red: 15, green: 110, blue: 177).cgColor
    }
    
    @IBAction func nextTouchUpInside(_ sender: UIButton) {
        let createUserPasswordViewController = CreateUserPasswordViewController()
        self.navigationController?.pushViewController(createUserPasswordViewController, animated: true)
    }
}
