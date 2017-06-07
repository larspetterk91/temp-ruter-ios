//
//  AppDelegate.swift
//  RuterPilot_WIP
//
//  Created by Lars Petter Kristiansen on 22/05/2017.
//  Copyright © 2017 Lars Petter Kristiansen. All rights reserved.
//

import UIKit
import RuterGOSDK

import Firebase
import FirebaseDatabase
import FirebaseRemoteConfig

import Intercom
import Instabug

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let utils = Utils()
    
    // Firebase
    fileprivate var firebaseDbRef: FIRDatabaseReference?
    fileprivate var remoteConfig: FIRRemoteConfig?
    fileprivate var developerMode = false
    fileprivate var bundleId = ""
    
    var appId: String {
        get {
            if let appId = UserDefaults.standard.string(forKey: "app.appid1") {
                return appId
            } else {
                let appId = AppTools.generateAppId()
                self.appId = appId
                return appId
            }
        }
        set {
            print("This newValue: \(newValue)")
            UserDefaults.standard.set(newValue, forKey: "app.appid1")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Firebase and logger
        setupFirebaseAll()
        configFirebaseForCurrentApp()
        setupLogger()
        fetchFirebaseRemoteSettings()
        
        startApplicationServices()
        
        setupIntercom()
        setupInstabug()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        TripManager.shared.suspend()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        TripManager.shared.start()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// MARK: - Firebase setup

extension AppDelegate {
    
    fileprivate func configFirebaseForCurrentApp() {
        FIRAnalyticsConfiguration.sharedInstance().setAnalyticsCollectionEnabled(true)
    }
    
}

extension AppDelegate {
    
    fileprivate func setupFirebaseAll() {
        if let bundleId = Bundle.main.bundleIdentifier?.replacingOccurrences(of: ".", with: "-") {
            self.bundleId = bundleId
        }
        let coreConfigFileName = "gs-" + bundleId + "-info"
        
        setupFirebaseCore(coreConfigFileName)
        setupFirebaseAnalytics()
        setupFirebaseDatabase()
        setupFirebaseRemoteConfig()
    }
    
    fileprivate func setupFirebaseCore(_ fileName: String) {
        if let firebaseConfigFile = Bundle.main.path(forResource: fileName, ofType: "plist"),
            let options = FIROptions(contentsOfFile: firebaseConfigFile) {
            FIRApp.configure(with: options)
        }
    }
    
    // MARK: - Analytics
    
    fileprivate func setupFirebaseAnalytics() {
        FIRAnalytics.setUserPropertyString(appId, forName: "appId")
    }
    
    // MARK: - Realtime Database
    
    fileprivate func setupFirebaseDatabase() {
        firebaseDbRef = FIRDatabase.database().reference()
    }
    
    // MARK: - Remote config
    
    fileprivate func setupFirebaseRemoteConfig() {
        if let remoteConfigFile = Bundle.main.path(forResource: "RemoteConfigDefaults", ofType: "plist") {
            remoteConfig = FIRRemoteConfig.remoteConfig()
            remoteConfig?.setDefaultsFromPlistFileName(remoteConfigFile)
        }
    }
    
    fileprivate func fetchFirebaseRemoteSettings() {
        var expirtationDuration = 3600
        #if (DEBUG)
            expirtationDuration = 30
        #endif
        
        let remoteConfigSettings = FIRRemoteConfigSettings(developerModeEnabled: developerMode)
        remoteConfig?.configSettings = remoteConfigSettings!
        remoteConfig?.fetch(withExpirationDuration: TimeInterval(expirtationDuration)) { (status, error) -> Void in
            if status == .success {
                Log.debug("Firebase: Config fetched!")
                self.remoteConfig?.activateFetched()
            } else {
                Log.error("Firebase: Config not fetched")
                Log.error("Firebase: Error \(error!.localizedDescription)")
            }
            self.applyFirebaseRemoteSettings()
        }
    }
    
    fileprivate func applyFirebaseRemoteSettings() {
        guard let proximityMaxRequiredRssiAll = self.remoteConfig?["proximity_max_required_rssi_all"].numberValue,
            let proximityMinRequiredRssiFront = self.remoteConfig?["proximity_min_required_rssi_front"].numberValue,
            let proximityMinRequiredRssiBack = self.remoteConfig?["proximity_min_required_rssi_back"].numberValue,
            let rangingMinRequiredSamples = self.remoteConfig?["ranging_min_required_samples"].numberValue,
            let rangingMaxIntervals = self.remoteConfig?["ranging_max_intervals"].numberValue else {
                return
        }
        
        let proximityConfig = ProximityConfig(maxRequiredRssiAll: proximityMaxRequiredRssiAll.doubleValue, minRequiredRssiFront: proximityMinRequiredRssiFront.doubleValue, minRequiredRssiBack: proximityMinRequiredRssiBack.doubleValue)
        TripManager.shared.activateProximityConfig(proximityConfig)
        
        let rangingConig = RangingConfig(minRequiredSamples: rangingMinRequiredSamples.intValue, maxIntervals: rangingMaxIntervals.intValue)
        TripManager.shared.activateRagingConfig(rangingConig)
    }
    
    func startApplicationServices() {
         let defaultsPrefix = "PREFIX_FOR_USERDEFAULTS"
         let runMode = RunMode.development
         let userProfile = UserProfile(appId: appId, backendKey: "KEY", backendSecret: "SECRET")
         TripManager.shared.setup(userProfile: userProfile, defaultsPrefix: defaultsPrefix, runMode: runMode)
         TripManager.shared.start()
    }
}

// MARK: - Logger

extension AppDelegate: LoggerDelegate {
    
    fileprivate func setupLogger() {
        Logger.shared.delegate = self
    }
    
    public func didLog(_ timeString: String, logLevel: LogLevel, message: Any) {
        
        // Console logging
        print("\(timeString) \(logLevel.stringValue) \(message)")
        
        // Do not log verbose to cloud database
        if logLevel == .verbose {
            return
        }
        firebaseDbRef?.child(bundleId).child("logs").child(appId).child(Log.launchTimeString).child(timeString).setValue("[\(logLevel.stringValue)] \(message)")
    }
}

// MARK: - Intercom

extension AppDelegate {
    
    fileprivate func setupIntercom(){
        // Intercom
        Intercom.setApiKey("ios_sdk-34ffeec39fcb52c8df057d98958fa89283c8d7b6", forAppId: "m9uctu3m")
        
        // In your application’s delegate didFinishLaunchingWithOptions method (or wherever you check your user’s authenticated state when your app starts up):
        let loggedIn = true
        if loggedIn {
            // We’re logged in, we can register the user with Intercom
            Intercom.registerUser(withUserId: "\(appId)")
            
        }
        
        let userAttributes = ICMUserAttributes()
        userAttributes.customAttributes = [
            "app_version": 99007 // Number
        ]
        Intercom.updateUser(userAttributes)
    }
}

// MARK: - Instabug

extension AppDelegate {
    
    fileprivate func setupInstabug(){
        Instabug.start(withToken: "601d64fd0ea7af8db9584c92ed997b13", invocationEvent: .shake)
    }
    
}










