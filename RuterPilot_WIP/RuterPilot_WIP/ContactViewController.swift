//
//  ContactViewController.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 29/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController /*, UIWebViewDelegate*/ {

    @IBOutlet var webView: UIWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let contactURL = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController {
            navigationController.isNavigationBarHidden = true
        }
        
        //webView.delegate = self
        //loadFirstAid()
    }
    /*
    func webViewDidStartLoad(_ webView: UIWebView){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
    }
    func webViewDidFinishLoad(_ webView: UIWebView){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func loadFirstAid(){
        webView.loadRequest(URLRequest(url: contactURL!))
    }*/

}
