//
//  OnboardingRootViewController.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 22/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import UIKit
import Intercom

class OnboardingRootViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webView: UIWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var contentView: UIView!
    
    var selectedNavigationController: UINavigationController?
    
    let ticketURL = URL(string: "https://test-kontoweb.ruter.no/start?hideFooter=true&appId=\(Bundle.main.bundleIdentifier!)&tripId=123456")
    
    let utils = Utils()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.refreshContentView()
        
        if let tickUrl = ticketURL {
            print("Onboarding URL: \(tickUrl)")
        }
        
        if let navigationController = navigationController {
            navigationController.isNavigationBarHidden = true
            navigationController.navigationBar.isTranslucent = false
        }
        
        webView.delegate = self
        loadFirstAid()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    var count = 0
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        count += 1
        
        print("\n\n --- --- --- URL CHANGES --- --- --- \n\n")
        
        //let path = request.url
        
        if let reqURL = request.url {
            print("|------------------------------------------------------------------------------------------------------------------------")
            print("|")
            print("|    REQUEST URL: \(reqURL)")
            print("|")
            
            var subStringLenght = -9
            
            let path:String = reqURL.absoluteString
            let lastSubstring = path.substring(from:path.index(path.endIndex, offsetBy: subStringLenght))
            
            let lastSubstringTicket = path.substring(from:path.index(path.endIndex, offsetBy: -6))
        
            print("|    Last \(subStringLenght): \(lastSubstring)")
            print("|")
            print("|    Last -6: \(lastSubstringTicket)")
            
            
            
            
            
            
            
            
            
            if lastSubstring == "mobilepay" {
                // set onboarding completed
                //utils.setUserDefault(key: "onboardingCompleted", value: true as AnyObject)
                //removeOnboardingView()
                print("|    Sucesserino")
                print("|")
            } else if lastSubstringTicket == "ticket" {
                print("|    It equals ticketino!")
                utils.setUserDefault(key: "onboardingCompleted", value: true as AnyObject)
                removeOnboardingView()
            } else {
                print("|    LINK/URL: \(path)")
                print("|")
                
            }
            

            
            if lastSubstring == "finish" {
                // dismiss viewcontroller
            }
        }
        print("|")
        print("|    Antall ganger metoden har kjørt:    \(count)")
        print("|")
        print("|------------------------------------------------------------------------------------------------------------------------")


        
        return true
    }
    
    func removeOnboardingView(){
        // Go to app
        print("Remove Onbarding View method.")
        
        // Define identifier
        let notifyDidLogin = Notification.Name("DidLogin")
        let notifyExitFullscreen = Notification.Name("ExitFullScreen")
        
        // Post notification
        NotificationCenter.default.post(name: notifyExitFullscreen, object: nil)
        NotificationCenter.default.post(name: notifyDidLogin, object: nil)
    }
    
    func loadFirstAid(){
        webView.loadRequest(URLRequest(url: ticketURL!))
    }
    
    func successfulLogin() {
        // For best results, use a unique user_id if you have one.
        Intercom.registerUser(withUserId: "123456")
    }
    

    func refreshContentView(){
        if (self.selectedNavigationController != nil) {
            self.selectedNavigationController?.willMove(toParentViewController: nil)
            self.selectedNavigationController?.view.removeFromSuperview()
            self.removeFromParentViewController()
            self.selectedNavigationController = nil
        }
        
        let onboardingIntroViewController = OnboardIntroViewController()
        let onboardingNavigationController = UINavigationController(rootViewController: onboardingIntroViewController)
        self.selectedNavigationController = onboardingNavigationController
        
        if (self.selectedNavigationController != nil) {
            self.addChildViewController(self.selectedNavigationController!)
            self.selectedNavigationController!.view.frame = self.contentView.bounds
            self.contentView.addSubview(self.selectedNavigationController!.view)
            self.selectedNavigationController?.didMove(toParentViewController: self)
        }
    }
    
    @IBAction func backTouchUpInside(_ sender: UIButton) {
        //_ = self.selectedNavigationController?.popViewController(animated: true)
        // Define identifier
        let notifyDidLogin = Notification.Name("DidLogin")
        
        // Post notification
        NotificationCenter.default.post(name: notifyDidLogin, object: nil)
    }
}
