//
//  AppDelegate.swift
//  WeiBo
//
//  Created by cjfire on 15/11/16.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = defaultRootViewController
        window?.makeKeyAndVisible()
        
        NSNotificationCenter.defaultCenter().addObserverForName(SwitchRootViewControllerNotification, object: nil, queue: nil) { (notificaiton) -> Void in
            
            if let notificationInfo = notificaiton.userInfo?["fromClass"] as? String {
                
                if notificationInfo == NSStringFromClass(OAuthViewController.self) {
                
                    self.window?.rootViewController = self.defaultRootViewController
                } else {
                    
                    self.window?.rootViewController = MainViewController()
                }
            }
        }
        
        return true
    }

    var defaultRootViewController: UIViewController {
        
        if UserAccountViewModel.shareUserAccountViewModel.loginFlag {
            return isNewVision ? NewFeatureViewController() : WelcomeViewController()
        }
        
        return MainViewController()
    }
    
    var isNewVision: Bool {
        
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let lastVersion = NSUserDefaults.standardUserDefaults().stringForKey("version")
        
        var newVersion: Bool
        
        if lastVersion == nil || currentVersion != lastVersion {
            newVersion = true
            
            NSUserDefaults.standardUserDefaults().setObject("\(currentVersion)", forKey: "version")
        } else {
            newVersion = false
        }
        
        return newVersion
    }

}

