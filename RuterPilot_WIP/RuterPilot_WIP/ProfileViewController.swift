//
//  ProfileViewController.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 29/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import UIKit
import Intercom

class ProfileViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let profileURL = URL(string: "https://test-kontoweb.ruter.no/profil?hideFooter=false")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController {
            navigationController.isNavigationBarHidden = true
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
    
    func loadFirstAid(){
        webView.loadRequest(URLRequest(url: profileURL!))
    }
    
    // use this method when logging out
    func logout() {
        // This resets the Intercom for iOS cache of your users’ identities
        // and wipes the slate clean.
        Intercom.reset()
    }
}
