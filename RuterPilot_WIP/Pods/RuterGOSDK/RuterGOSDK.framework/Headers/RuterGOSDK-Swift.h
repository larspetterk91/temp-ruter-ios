// Generated by Apple Swift version 3.1 (swiftlang-802.0.53 clang-802.0.42)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if defined(__has_attribute) && __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import CoreLocation;
@import Foundation;
@import UIKit;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
typedef SWIFT_ENUM(NSInteger, BeaconGroup) {
  BeaconGroupFront = 0,
  BeaconGroupCenter = 1,
  BeaconGroupBack = 2,
};

@class CLBeaconRegion;

/// Logger for collecting beacon data for a specified beacon region (UUID + identifier).
/// Includes a renderer for output in JSON format.
SWIFT_CLASS("_TtC10RuterGOSDK12BeaconLogger")
@interface BeaconLogger : NSObject
@property (nonatomic) NSInteger selectedMajor;
- (void)startRangingWithRegion:(CLBeaconRegion * _Nonnull)region;
- (void)startLogging;
- (void)stopLoggingWithCompletion:(SWIFT_NOESCAPE void (^ _Nonnull)(NSDictionary<NSString *, id> * _Nonnull))completion;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class CLLocationManager;
@class CLBeacon;

@interface BeaconLogger (SWIFT_EXTENSION(RuterGOSDK)) <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager * _Nonnull)manager didRangeBeacons:(NSArray<CLBeacon *> * _Nonnull)beacons inRegion:(CLBeaconRegion * _Nonnull)region;
@end

/// Placement of beacon onboard an vehicle where the config consists of 6 beacons.
/// The rawValue correlates with the beacon minor value.
/// Front:
/// <ul>
///   <li>
///     Left (1)
///   </li>
///   <li>
///     Right (2)
///   </li>
/// </ul>
/// Center:
/// <ul>
///   <li>
///     Left (3)
///   </li>
///   <li>
///     Right (4)
///   </li>
/// </ul>
/// Back:
/// <ul>
///   <li>
///     Left (5)
///   </li>
///   <li>
///     Right (6)
///   </li>
/// </ul>
typedef SWIFT_ENUM(NSInteger, BeaconPlacement) {
  BeaconPlacementFrontLeft = 1,
  BeaconPlacementFrontRight = 2,
  BeaconPlacementCenterLeft = 3,
  BeaconPlacementCenterRight = 4,
  BeaconPlacementBackLeft = 5,
  BeaconPlacementBackRight = 6,
};

/// State of ranging
/// <ul>
///   <li>
///     Passive: No ranging in process
///   </li>
///   <li>
///     VehicleDetection: Ranging to evaluate which vehicle has the strongest RSSI sum value, hence the closest.
///   </li>
///   <li>
///     OnboardDetection: Ranging to evalutate if user is onboard the give vehicle.
///   </li>
/// </ul>
typedef SWIFT_ENUM(NSInteger, DetectionState) {
  DetectionStatePassive = 0,
  DetectionStateVehicleDetection = 1,
  DetectionStateOnboardDetection = 2,
};


@interface NSObject (SWIFT_EXTENSION(RuterGOSDK))
@end

enum ProximityState : NSInteger;
@class CLRegion;

/// Handles the state of proximity of a transport vehicle.
/// Supports monitoring beacons invoking ranging and wraps proximity analyzer for evaluating
/// proximity such as outside, near or inside of vehicle. Also registers for monitoring exit of vehicle.
SWIFT_CLASS("_TtC10RuterGOSDK16ProximityManager")
@interface ProximityManager : NSObject <CLLocationManagerDelegate>
@property (nonatomic, readonly) enum ProximityState proximityState;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didStartMonitoringForRegion:(CLRegion * _Nonnull)region;
- (void)locationManager:(CLLocationManager * _Nonnull)manager monitoringDidFailForRegion:(CLRegion * _Nullable)region withError:(NSError * _Nonnull)error;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didEnterRegion:(CLRegion * _Nonnull)region;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didExitRegion:(CLRegion * _Nonnull)region;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion * _Nonnull)region;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didRangeBeacons:(NSArray<CLBeacon *> * _Nonnull)beacons inRegion:(CLBeaconRegion * _Nonnull)region;
- (void)locationManager:(CLLocationManager * _Nonnull)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion * _Nonnull)region withError:(NSError * _Nonnull)error;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

/// State of proximity of a transport vehicle.
/// <ul>
///   <li>
///     Outside: not within range of vehicle at all
///   </li>
///   <li>
///     Near: vehicle has been detected, but not determined as insde of vehicle
///   </li>
///   <li>
///     Inside: has been positively identified as inside of vehicle
///   </li>
/// </ul>
typedef SWIFT_ENUM(NSInteger, ProximityState) {
  ProximityStateOutside = 1,
  ProximityStateNear = 2,
  ProximityStateInside = 3,
};

typedef SWIFT_ENUM(NSInteger, ServiceState) {
  ServiceStateRunning = 0,
  ServiceStateSuspended = 1,
  ServiceStateStopped = 2,
};

typedef SWIFT_ENUM(NSInteger, TaskState) {
  TaskStateBusy = 0,
  TaskStateInactive = 1,
};

enum TripState : NSInteger;

SWIFT_CLASS("_TtC10RuterGOSDK4Trip")
@interface Trip : NSObject
@property (nonatomic, copy) NSString * _Nonnull appId;
@property (nonatomic, copy) NSUUID * _Nullable tripId;
@property (nonatomic) enum TripState state;
@property (nonatomic, copy) NSDate * _Nullable startTime;
@property (nonatomic, copy) NSDate * _Nullable endTime;
@property (nonatomic) NSInteger vehicleId;
/// Duration in seconds between start and end stop. If one is nil, zero is returned
@property (nonatomic, readonly) double duration;
/// Distance in meters between start and end location. If one is nil, zero is returned
@property (nonatomic, readonly) double distance;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface Trip (SWIFT_EXTENSION(RuterGOSDK))
@property (nonatomic, readonly, copy) NSDictionary<NSString *, id> * _Nonnull json;
@property (nonatomic, readonly, copy) NSString * _Nonnull debugDescription;
@end


/// Managing various stages of trip state.
SWIFT_CLASS("_TtC10RuterGOSDK11TripManager")
@interface TripManager : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) TripManager * _Nonnull shared;)
+ (TripManager * _Nonnull)shared SWIFT_WARN_UNUSED_RESULT;
@property (nonatomic, readonly, copy) NSString * _Nonnull appId;
@property (nonatomic, readonly) NSInteger vehicleId;
@property (nonatomic, readonly) enum ProximityState proximityState;
@property (nonatomic, readonly) enum TripState tripState;
@property (nonatomic) NSInteger destinationStopId;
@property (nonatomic, readonly) enum ServiceState serviceState;
- (void)appendDelegate:(NSObject * _Nonnull)delegate;
- (void)removeDelegate:(NSObject * _Nonnull)delegate;
- (void)removeAllDelegates;
/// Starts service and resumes current trip if saved trip state equals started.
- (void)start;
/// Suspends services and keeps necessary background monitoring.
- (void)suspend;
/// Stops all ranging and background monitoring.
- (void)stop;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface TripManager (SWIFT_EXTENSION(RuterGOSDK))
@end


@interface TripManager (SWIFT_EXTENSION(RuterGOSDK))
@end


@interface TripManager (SWIFT_EXTENSION(RuterGOSDK))
@end


@interface TripManager (SWIFT_EXTENSION(RuterGOSDK))
- (UIBackgroundTaskIdentifier)startBackgroundTask SWIFT_WARN_UNUSED_RESULT;
- (void)endBackgroundTaskWithIdentifier:(UIBackgroundTaskIdentifier)identifier;
@end


@interface TripManager (SWIFT_EXTENSION(RuterGOSDK))
@end


@interface TripManager (SWIFT_EXTENSION(RuterGOSDK))
- (void)multicastNearestVehiclesDetected:(NSArray<NSNumber *> * _Nonnull)vehicles;
- (void)multicastServiceStateDidChange:(enum ServiceState)serviceState;
- (void)multicastProximityDidChange:(enum ProximityState)proximityState vehicleId:(NSInteger)vehicleId;
- (void)multicastTripDidChange:(Trip * _Nullable)trip;
- (void)multicastMQTTDidConnect;
- (void)multicastMQTTDidDisconnect;
@end


@interface TripManager (SWIFT_EXTENSION(RuterGOSDK))
- (void)postDeviceProperties:(NSDictionary<NSString *, id> * _Nonnull)json completion:(void (^ _Nonnull)(BOOL))completion;
- (void)getTrips:(NSString * _Nonnull)appId completion:(void (^ _Nonnull)(NSArray<Trip *> * _Nonnull))completion;
- (void)getTrip:(NSUUID * _Nonnull)uuid completion:(void (^ _Nonnull)(Trip * _Nullable))completion;
- (void)postBeaconData:(NSDictionary<NSString *, id> * _Nonnull)json path:(NSString * _Nonnull)path completion:(void (^ _Nonnull)(BOOL))completion;
@end


@interface TripManager (SWIFT_EXTENSION(RuterGOSDK))
- (void)mqttConnect;
- (void)mqttDisconnect;
- (void)mqttSubscribeVehicleUpdatesWithVehicleId:(NSInteger)vehicleId;
- (void)mqttUnsubscribeAll;
@end


@interface TripManager (SWIFT_EXTENSION(RuterGOSDK))
@property (nonatomic, readonly) BOOL isHealthProviderAvailable;
@property (nonatomic, readonly) BOOL isMotionProviderAvailable;
- (void)requestHealthAuthorizationWithCompletion:(void (^ _Nonnull)(BOOL))completion;
- (void)distanceWalkingRunningWithTimeInterval:(NSTimeInterval)timeInterval completion:(void (^ _Nonnull)(double))completion;
@end


/// TripManager protocol
SWIFT_PROTOCOL("_TtP10RuterGOSDK19TripManagerDelegate_")
@protocol TripManagerDelegate
@optional
- (void)tripManagerNearestVehiclesDetected:(NSArray<NSNumber *> * _Nonnull)vehicles;
- (void)tripManagerProximityDidChange:(enum ProximityState)proximityState vehicleId:(NSInteger)vehicleId;
- (void)tripManagerServiceStateDidChange:(enum ServiceState)serviceState;
- (void)tripManagerTripDidChange:(Trip * _Nullable)trip;
- (void)tripManagerMQTTDidConnect;
- (void)tripManagerMQTTDidDisconnect;
@end

typedef SWIFT_ENUM(NSInteger, TripState) {
  TripStateNotSet = 0,
  TripStateInactive = 1,
  TripStateStarted = 2,
  TripStateCompleted = 3,
};

#pragma clang diagnostic pop
