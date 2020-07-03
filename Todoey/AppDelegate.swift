//
//  AppDelegate.swift
//  Todoey
//
//  Created by Allan Rosa on 08/06/2020.
//  Copyright © 2020 Allan Rosa. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            let _ = try Realm()
        } catch {
            print("Error initialising new realm, \(error)")
        }
        return true
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }

    
    
    
}
