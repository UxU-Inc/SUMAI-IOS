//
//  AppDelegate.swift
//  SUMAI
//
//  Created by 서영규 on 2021/02/22.
//

import SwiftUI
import Firebase
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //firebase
        FirebaseApp.configure()
        
        //admob
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }
}
