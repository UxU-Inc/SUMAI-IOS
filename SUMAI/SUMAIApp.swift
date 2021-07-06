//
//  SUMAIApp.swift
//  SUMAI
//
//  Created by 서영규 on 2021/01/28.
//

import SwiftUI

@main
struct SUMAIApp: App {
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                MainView()
                    .navigationBarHidden(true)
                PolicyView()
            }
            //.preferredColorScheme(.light) // darkmode ignore
        }
    }
}
