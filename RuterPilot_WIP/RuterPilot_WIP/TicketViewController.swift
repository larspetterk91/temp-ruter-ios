//
//  TicketViewController.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 29/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import UIKit
import RuterGOSDK
import WebKit

class TicketViewController: UIViewController, UIWebViewDelegate, WKScriptMessageHandler {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var webView: UIWebView!
    
    let ticketURL = URL(string: "https://test-kontoweb.ruter.no/ticket?hideFooter=true&appId=\(Bundle.main.bundleIdentifier!)&tripId=123456")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To start recieving detegate calls
        //TripManager.shared.appendDelegate(self)
        
        if let tickUrl = ticketURL {
            print("Ticket URL: \(tickUrl)")
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
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == UIWebViewNavigationType.linkClicked {
            return false
        }
        
        if let url = request.url {
            
            let path : String = url.absoluteString
            
            print("REQUEST URL: \(path)")
            /*
            if path.range(of: "&app=1") != nil {
                // everything is fine.
                return true
            } else {
                let requestUrl = URL(string:"www.vg.no")
                let newRequest = URLRequest(url:requestUrl!)
                webView.loadRequest(newRequest)
                return false
            }*/
        }
        
        return true
    }
    
    func loadFirstAid(){
        webView.loadRequest(URLRequest(url: ticketURL!))
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        print("userContentController <3")
        
        
        if message.name == "event" {
            guard let body = message.body as? [String: Any] else { return }
            guard let type = body["type"] as? String else { return }
            if type == "API_KEYS_OBTAINED" {
                // Get api key and secret and save to keychain
                guard let apiKeys = body["apiKeys"] as? [String: Any] else { return }
                guard let key = apiKeys["id"] as? String else { return }
                guard let secret = apiKeys["secret"] as? String else { return }
                
                // IMPORTANT! SAVE API KEYS ON LOCAL IOS KEYCHAIN!
            }
        }
    }
}
