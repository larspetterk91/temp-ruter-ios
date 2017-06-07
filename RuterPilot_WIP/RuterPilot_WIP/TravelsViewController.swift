//
//  TravelsViewController.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 29/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import UIKit
import CoreLocation

class TravelsViewController: UIViewController /*, CLLocationManagerDelegate , UIWebViewDelegate */ {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var webView: UIWebView!
    
    let travelURL = URL(string: "")
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController {
            navigationController.isNavigationBarHidden = true
        }
        
        //locationManager = CLLocationManager()
        //locationManager.delegate = self
        //locationManager.requestAlwaysAuthorization()
        
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
        webView.loadRequest(URLRequest(url: travelURL!))
    }*/
    
    // MARK: Beacon methods and Location Manager Delegate methods:
    /*
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        //print("Beacon starting scanning...")
        let uuid = UUID(uuidString: "95AF234D-ACA2-4D27-BA06-0C40941477AF")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 4664, minor: 1, identifier: "ruterBeacon")
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        if beacons.count > 0 {
            updateDistance(beacons[0].proximity)
        } else {
            updateDistance(.unknown)
        }
    }
    
    func updateDistance(_ distance: CLProximity){
        
        //print("Beacon distance: \(distance)")
        
        UIView.animate(withDuration: 0.8){
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
            case .far:
                self.view.backgroundColor = UIColor.blue
            case .near:
                self.view.backgroundColor = UIColor.orange
            case .immediate:
                self.view.backgroundColor = UIColor.red
            }
        }
    }*/
}
