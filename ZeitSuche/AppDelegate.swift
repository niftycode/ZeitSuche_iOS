//
//  AppDelegate.swift
//  ZeitSuche
//
//  Created by Bodo Schönfeld on 10/06/16.
//  Copyright © 2016 Bodo Schönfeld. All rights reserved.
//

import UIKit

extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int)
    {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func customizeAppearance() {
        let barTintColor = UIColor(red: 196, green: 39, blue: 91)
        UISearchBar.appearance().barTintColor = barTintColor
        window!.tintColor = UIColor(red: 196, green: 39, blue: 91)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        customizeAppearance()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

