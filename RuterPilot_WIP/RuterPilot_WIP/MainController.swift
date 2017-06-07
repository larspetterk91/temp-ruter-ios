//
//  MainController.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 22/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import UIKit
import CoreBluetooth
import RuterGOSDK
import Intercom

class MainController: UIViewController, CBCentralManagerDelegate, TripManagerDelegate {

    @IBOutlet var contentView: UIView!
    @IBOutlet var tabbarView: UIView!
    
    @IBOutlet var btnOne: UIButton!
    @IBOutlet var btnTwo: UIButton!
    @IBOutlet var btnThree: UIButton!
    @IBOutlet var btnFour: UIButton!
    
    var selectedNavigationController: UINavigationController?
    
    @IBOutlet var tabBarBottomSpaceConstraint: NSLayoutConstraint!
    
    let utils = Utils()
    
    var bluetoothManager: CBCentralManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TripManager.shared.start()
        
        Intercom.setLauncherVisible(true)
        
        // center tab bar buttons horizontally and vertically
        btnOne.alignImageAndTitleVertically()
        btnTwo.alignImageAndTitleVertically()
        btnThree.alignImageAndTitleVertically()
        btnFour.alignImageAndTitleVertically()
        
        // bluetooth:
        bluetoothManager = CBCentralManager(delegate: self, queue: nil)
        
        // hide navbar and change background on webview
        if let navigationController = navigationController {
            navigationController.isNavigationBarHidden = true
            navigationController.navigationBar.isTranslucent = false
        }
        
        // Define identifier
        let notifyUserDidLogin = Notification.Name("DidLogin")
        let notifyExitFullscreen = Notification.Name("ExitFullScreen")
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(MainController.userDidLogin), name: notifyUserDidLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MainController.exitFullScreen), name: notifyExitFullscreen, object: nil)
        
        self.refreshContentView()
    }
    
    var isBluetoothOn = false
    
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        var consoleMsg = ""
        
        
        switch central.state {
        case .poweredOff:
            consoleMsg = "BLE is powered off"
            isBluetoothOn = false
        case .poweredOn:
            consoleMsg = "BLE is powered on"
            isBluetoothOn = true
        case .resetting:
            consoleMsg = "BLE is resetting"
        case .unauthorized:
            consoleMsg = "BLE is unauthorized"
        case .unknown:
            consoleMsg = "BLE is powered off"
        case .unsupported:
            consoleMsg = "BLE is powered off"
        }
        
        print(consoleMsg)
        self.refreshContentView()
    }
    
    func refreshContentView(){
        if (self.selectedNavigationController != nil) {
            self.selectedNavigationController?.willMove(toParentViewController: nil)
            self.selectedNavigationController?.view.removeFromSuperview()
            self.removeFromParentViewController()
            self.selectedNavigationController = nil
        }
        
        if utils.getUserDefault(key: "onboardingCompleted") == nil {
            let onboardingRootViewController = OnboardingRootViewController()
            self.selectedNavigationController = UINavigationController(rootViewController: onboardingRootViewController)
            hideTabBar()
        } else {
            if(!isBluetoothOn){
                let bluetoothViewController = BluetoothViewController()
                self.selectedNavigationController = UINavigationController(rootViewController: bluetoothViewController)
            } else if (self.btnTwo.isSelected == true) {
                let travelsViewController = TravelsViewController()
                self.selectedNavigationController = UINavigationController(rootViewController: travelsViewController)
            }  else if (self.btnThree.isSelected == true) {
                let contactViewController = ContactViewController()
                self.selectedNavigationController = UINavigationController(rootViewController: contactViewController)
            }  else if (self.btnFour.isSelected == true) {
                let profileViewController = ProfileViewController()
                self.selectedNavigationController = UINavigationController(rootViewController: profileViewController)
            } else {
                let ticketViewController = TicketViewController()
                self.selectedNavigationController = UINavigationController(rootViewController: ticketViewController)
            }
        }
        
        if (self.selectedNavigationController != nil) {
            self.addChildViewController(self.selectedNavigationController!)
            self.selectedNavigationController!.view.frame = self.contentView.bounds
            self.contentView.addSubview(self.selectedNavigationController!.view)
            self.selectedNavigationController?.didMove(toParentViewController: self)
        }
    }
    
    @IBAction func tabBarButtonTouchUpInside(_ sender: UIButton) {
        let selectedButton = sender
        
        if (selectedButton.isSelected == true) {
            return
        }
        
        self.clearTabBarButtonsStates()
        
        selectedButton.isSelected = true
        selectedButton.accessibilityTraits = UIAccessibilityTraitSelected
        
        self.refreshContentView()
    }
    
    func clearTabBarButtonsStates() {
        self.btnOne.isSelected = false
        self.btnTwo.isSelected = false
        self.btnThree.isSelected = false
        self.btnFour.isSelected = false
        
        self.btnOne.accessibilityTraits = 0
        self.btnTwo.accessibilityTraits = 0
        self.btnThree.accessibilityTraits = 0
        self.btnFour.accessibilityTraits = 0
    }
    
    func hideTabBar(){
        self.tabBarBottomSpaceConstraint.constant = -self.tabbarView.frame.size.height
        self.view.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: {self.view.layoutIfNeeded()}, completion: nil)
        
    }
    
    func showTabBar(){
        self.tabBarBottomSpaceConstraint.constant = 0
        self.view.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: {self.view.layoutIfNeeded()}, completion: nil)
    }
    
    // MARK: Notification metoder
    
    func enterFullScreen(Notification: NSNotification) {
        hideTabBar()
    }
    
    func exitFullScreen(Notification: NSNotification){
        print("exit full screen method.")
        showTabBar()
    }
    
    func userDidLogin(Notification: NSNotification) {
        print("User did login method.")
        self.refreshContentView()
    }
    
    func tripManagerTripDidChange(_ trip: Trip?) {
        print("tripManagerDidChange!")
    }
    
    func tripManagerProximityDidChange(_ proximityState: ProximityState, vehicleId: Int) {
        print("tripManagerProximityDidChange")
    }
    
    func tripManagerNearestVehiclesDetected(_ vehicles: [Int]) {
        print("tripManagerNearestVehiclesDetected")
    }
    
    func tripManagerServiceStateDidChange(_ serviceState: ServiceState) {
        print("tripManagerServiceStateDidChange")
    }
}


@objc public protocol TripManagerDelegate: class {
    @objc optional func tripManagerNearestVehiclesDetected(_ vehicles: [Int])
    @objc optional func tripManagerProximityDidChange(_ proximityState: ProximityState, vehicleId: Int)
    @objc optional func tripManagerServiceStateDidChange(_ serviceState: ServiceState)
    @objc optional func tripManagerTripDidChange(_ trip: Trip?)
}

extension UIButton {
    func alignImageAndTitleVertically(padding: CGFloat = 6.0) {
        let imageSize: CGSize = imageView!.image!.size
        titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + padding), 0.0)
        let labelString = NSString(string: titleLabel!.text!)
        let titleSize = labelString.size(attributes: [NSFontAttributeName: titleLabel!.font])
        self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + padding), 0.0, 0.0, -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        self.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0)
    }
}
