//
//  PluggableApplicationDelegate.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit
import CloudKit

/// This is only a tagging protocol.
/// It doesn't add more functionalities yet.
public protocol ApplicationService: UIApplicationDelegate {}

open class PluggableApplicationDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    
    open var services: [ApplicationService] { return [] }
    
    private lazy var __services: [ApplicationService] = {
        return self.services
    }()
    
    open func applicationDidFinishLaunching(_ application: UIApplication) {
        __services.forEach { $0.applicationDidFinishLaunching?(application) }
    }
    
    open func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        var result = false
        for service in __services {
            if service.application?(application, willFinishLaunchingWithOptions: launchOptions) ?? false {
                result = true
            }
        }
        return result
    }
    
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        var result = false
        for service in __services {
            if service.application?(application, didFinishLaunchingWithOptions: launchOptions) ?? false {
                result = true
            }
        }
        return result
    }
    
    open func applicationDidBecomeActive(_ application: UIApplication) {
        for service in __services {
            service.applicationDidBecomeActive?(application)
        }
    }
    
    open func applicationWillResignActive(_ application: UIApplication) {
        for service in __services {
            service.applicationWillResignActive?(application)
        }
    }
    
    open func application(_ app: UIApplication, public url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        var result = false
        for service in __services {
            if service.application?(app, open: url, options: options) ?? false {
                result = true
            }
        }
        return result
    }
    
    open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        for service in __services {
            service.applicationDidReceiveMemoryWarning?(application)
        }
    }
    
    open func applicationWillTerminate(_ application: UIApplication) {
        for service in __services {
            service.applicationWillTerminate?(application)
        }
    }
    
    open func applicationSignificantTimeChange(_ application: UIApplication) {
        for service in __services {
            service.applicationSignificantTimeChange?(application)
        }
    }
    
    open func application(_ application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        for service in __services {
            service.application?(application, willChangeStatusBarOrientation: newStatusBarOrientation, duration: duration)
        }
    }
    
    open func application(_ application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
        for service in __services {
            service.application?(application, didChangeStatusBarOrientation: oldStatusBarOrientation)
        }
    }
    
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        for service in __services {
            service.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }
    
    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        for service in __services {
            service.application?(application, didFailToRegisterForRemoteNotificationsWithError: error)
        }
    }
    
    /*! This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
     
     This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases, and which will not be invoked if this method is implemented. !*/
    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Swift.Void) {
        for service in __services {
            service.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
        }
    }
    
    /// Applications with the "fetch" background mode may be given opportunities to fetch updated content in the background or when it is convenient for the system. This method will be called in these situations. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
    open func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Swift.Void) {
        for service in __services {
            service.application?(application, performFetchWithCompletionHandler: completionHandler)
        }
    }
    
    // Called when the user activates your application by selecting a shortcut on the home screen,
    // except when -application:willFinishLaunchingWithOptions: or -application:didFinishLaunchingWithOptions returns NO.
    open func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Swift.Void) {
        for service in __services {
            service.application?(application, performActionFor: shortcutItem, completionHandler: completionHandler)
        }
    }
    
    // Applications using an NSURLSession with a background configuration may be launched or resumed in the background in order to handle the
    // completion of tasks in that session, or to handle authentication. This method will be called with the identifier of the session needing
    // attention. Once a session has been created from a configuration object with that identifier, the session's delegate will begin receiving
    // callbacks. If such a session has already been created (if the app is being resumed, for instance), then the delegate will start receiving
    // callbacks without any action by the application. You should call the completionHandler as soon as you're finished handling the callbacks.
    open func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Swift.Void) {
        for service in __services {
            service.application?(application, handleEventsForBackgroundURLSession: identifier, completionHandler: completionHandler)
        }
    }
    
    open func application(_ application: UIApplication, handleWatchKitExtensionRequest userInfo: [AnyHashable: Any]?, reply: @escaping ([AnyHashable: Any]?) -> Swift.Void) {
        for service in __services {
            service.application?(application, handleWatchKitExtensionRequest: userInfo, reply: reply)
        }
    }
    
    open func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        for service in __services {
            service.applicationShouldRequestHealthAuthorization?(application)
        }
    }
    
    open func applicationDidEnterBackground(_ application: UIApplication) {
        for service in __services {
            service.applicationDidEnterBackground?(application)
        }
    }
    
    open func applicationWillEnterForeground(_ application: UIApplication) {
        for service in __services {
            service.applicationWillEnterForeground?(application)
        }
    }
    
    open func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        for service in __services {
            service.applicationProtectedDataWillBecomeUnavailable?(application)
        }
    }
    
    open func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        for service in __services {
            service.applicationProtectedDataDidBecomeAvailable?(application)
        }
    }
    
    // Applications may reject specific types of extensions based on the extension point identifier.
    // Constants representing common extension point identifiers are provided further down.
    // If unimplemented, the default behavior is to allow the extension point identifier.
    open func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        var result = false
        for service in __services {
            if service.application?(application, shouldAllowExtensionPointIdentifier: extensionPointIdentifier) ?? true {
                result = true
            }
        }
        return result
    }
    
    open func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
        for service in __services {
            if let viewController = service.application?(application, viewControllerWithRestorationIdentifierPath: identifierComponents, coder: coder) {
                return viewController
            }
        }
        
        return nil
    }
    
    open func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        var result = false
        for service in __services {
            if service.application?(application, shouldSaveApplicationState: coder) ?? false {
                result = true
            }
        }
        return result
    }
    
    open func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        var result = false
        for service in __services {
            if service.application?(application, shouldRestoreApplicationState: coder) ?? false {
                result = true
            }
        }
        return result
    }
    
    open func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        for service in __services {
            service.application?(application, willEncodeRestorableStateWith: coder)
        }
    }
    
    open func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        for service in __services {
            service.application?(application, didDecodeRestorableStateWith: coder)
        }
    }
    
    // Called on the main thread as soon as the user indicates they want to continue an activity in your application. The NSUserActivity object may not be available instantly,
    // so use this as an opportunity to show the user that an activity will be continued shortly.
    // For each application:willContinueUserActivityWithType: invocation, you are guaranteed to get exactly one invocation of application:continueUserActivity: on success,
    // or application:didFailToContinueUserActivityWithType:error: if an error was encountered.
    open func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        var result = false
        for service in __services {
            if service.application?(application, willContinueUserActivityWithType: userActivityType) ?? false {
                result = true
            }
        }
        return result
    }
    
    // Called on the main thread after the NSUserActivity object is available. Use the data you stored in the NSUserActivity object to re-create what the user was doing.
    // You can create/fetch any restorable objects associated with the user activity, and pass them to the restorationHandler. They will then have the UIResponder restoreUserActivityState: method
    // invoked with the user activity. Invoking the restorationHandler is optional. It may be copied and invoked later, and it will bounce to the main thread to complete its work and call
    // restoreUserActivityState on all objects.
    open func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Swift.Void) -> Bool {
        var result = false
        for service in __services {
            if service.application?(application, continue: userActivity, restorationHandler: restorationHandler) ?? false {
                result = true
            }
        }
        return result
    }
    
    // If the user activity cannot be fetched after willContinueUserActivityWithType is called, this will be called on the main thread when implemented.
    open func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        for service in __services {
            service.application?(application, didFailToContinueUserActivityWithType: userActivityType, error: error)
        }
    }
    
    // This is called on the main thread when a user activity managed by UIKit has been updated. You can use this as a last chance to add additional data to the userActivity.
    open func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        for service in __services {
            service.application?(application, didUpdate: userActivity)
        }
    }
    
    // This will be called on the main thread after the user indicates they want to accept a CloudKit sharing invitation in your application.
    // You should use the CKShareMetadata object's shareURL and containerIdentifier to schedule a CKAcceptSharesOperation, then start using
    // the resulting CKShare and its associated record(s), which will appear in the CKContainer's shared database in a zone matching that of the record's owner.
    open func application(_ application: UIApplication, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata) {
        for service in __services {
            service.application?(application, userDidAcceptCloudKitShareWith: cloudKitShareMetadata)
        }
    }
}
