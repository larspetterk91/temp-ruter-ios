# Introduction

RuterGO SDK is an iOS toolkit to enable beacon proximity services in regards to trips when traveling with selected vehicles and lines provided by Ruter.

All is managed by the TripManager for evaluating if user is inside or outside of vehicle (supports articulated bus only). If user is inside, a trip event is reported to backend. When user leaves the bus after a trip has started, then a trip completed event is reported to backend.

The framework will set a reference to UIApplication.shared internally enabling BackgroundTaskManager to handle long running tasks gracefully.

## Installation

Add this in your podfile:
```
pod 'RuterGOSDK', :git => 'https://stash.ruter.no/scm/nex/rutergo-sdk-ios.git', :branch => 'master'
```

## Usage

### Implementation

TripManager is a singleton implemented by providing parameters upon setup:

* **UserProfile** including parameters for unique app id for host app, account username and password hash.
* **UserDefaults prefix string** to save state for trip when app in closed (to avoid naming conflicts with host app)
* **RunMode** affects which beacon regions are used for detection and scanning
* **API keys** [id] and [secret] is returned from Stormpath when logging into account web. These should be secured locally on iOS keychain and provided to the SDK for backend interactions. [Obtainting API keys sample](#obtainting-api-keys)

#### AppDelegate Implementation
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    let defaultsPrefix = "PREFIX_FOR_USERDEFAULTS"
    let runMode = RunMode[.development | .production]
    let userProfile = UserProfile(appId: appId, backendKey: "KEY", backendSecret: "SECRET")
    TripManager.shared.setup(userProfile: userProfile, defaultsPrefix: defaultsPrefix, runMode: runMode)
    TripManager.shared.start()
}

func applicationDidEnterBackground(_ application: UIApplication) {
    TripManager.shared.suspend()
}

func applicationDidBecomeActive(_ application: UIApplication) {
    TripManager.shared.start()
}
```

#### TripManagerDelegate
Implementation is optional. Typically in viewcontroller(s) or a singleton helper class. The delegate supports multicast delegate implementation.

```swift
// To start recieving detegate calls
TripManager.shared.appendDelegate(self)

// To stop recieving detegate calls (cleanup)
TripManager.shared.removeDelegate(self)
```

#### TripManagerDelegate Protocol
```swift
public protocol TripManagerDelegate: class {
    optional func tripManagerNearestVehiclesDetected(_ vehicles: [Int])
    optional func tripManagerProximityDidChange(_ proximityState: ProximityState, vehicleId: Int)
    optional func tripManagerServiceStateDidChange(_ serviceState: ServiceState)
    optional func tripManagerTripDidChange(_ trip: Trip?)
}
```

### Obtainting API keys

Request string for webview: "https://test-kontoweb.ruter.no?hideMenu=false"

From WKWebView in [WebKit](https://developer.apple.com/reference/webkit) implement WKScriptMessageHandler.

```swift
func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
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
```

# Infrastructure

## General

Onboard selected vehicles, beacons from Estimote is provided. These are put into two categories and have each an function. The first function is to activate the hosting app from the framework by using *Invokers*. When the host app is running, the ranging of determining which bus has the closest proximity of the user and then starts ranging to determinate if user is inside of the vehicle or not. To achieve this, 6 other beacons are placed onboard with a stronger transmission signal measured in RSSI (dBm). On the current rig this value is set to -12 dBm.

Estimote measured calibration values at 1m (all in dBm):

Tx value | Measured value
--- | ---
-30 | -91
-20 | -81
-16 | -76
-12 | -74
 -8 | -68
 -4 | -66
  0 | -62
  4 | -60

## Beacon setup

Environment | UUID | Major | Minor
--- | --- | --- | ---
Dev Invoker | 72DE4779-E058-40D2-B1F6-9652655F1D9C | vehicle id | 1-4
Dev Ranger | 385B392C-45C2-4CBA-8295-95E264264E94 | vehicle id | 1-6
Prod invoker | 95AF234D-ACA2-4D27-BA06-0C40941477AF | vehicle id | 1-4
Prod ranger | F3899E46-CD3B-489A-83D7-636E3D2B80EA | vehicle id | 1-6

**IMPORTANT:** for SDK to trigger one needs at least one invoker (any minor) and 4 rangers (1-4 or 3-6)

## License

Ruter AS
