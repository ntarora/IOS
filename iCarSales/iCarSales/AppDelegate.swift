//
//  AppDelegate.swift
//  iCarSales
//
//  Created by Neel A on 12/9/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var make_dict_cars = NSMutableDictionary()
    var locationManager = CLLocationManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        
        // Add the plist filename to the documents directory path to obtain an absolute path to the plist filename
        let plistFilePathInDocumentDirectory = documentDirectoryPath + "/carInventory.plist"
        
        /*
        NSMutableDictionary manages an *unordered* collection of mutable (changeable) key-value pairs.
        Instantiate an NSMutableDictionary object and initialize it with the contents of the CountryCities.plist file.
        */
        let dictionaryFromFile: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFilePathInDocumentDirectory)
        
        /*
        IF the optional variable dictionaryFromFile has a value, THEN
        CountryCities.plist exists in the Documents directory and the dictionary is successfully created
        ELSE read CountryCities.plist from the application's main bundle.
        */
        if let dictionaryFromFileInDocumentDirectory = dictionaryFromFile {
            
            // CountryCities.plist exists in the Documents directory
            make_dict_cars = dictionaryFromFileInDocumentDirectory
            
        } else {
            
            // CountryCities.plist does not exist in the Documents directory; Read it from the main bundle.
            
            // Obtain the file path to the plist file in the mainBundle (project folder)
            let plistFilePathInMainBundle = NSBundle.mainBundle().pathForResource("carInventory", ofType: "plist")
            
            // Instantiate an NSMutableDictionary object and initialize it with the contents of the CountryCities.plist file.
            let dictionaryFromFileInMainBundle: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFilePathInMainBundle!)
            
            // Assign it to the instance variable
            make_dict_cars = dictionaryFromFileInMainBundle!
        }
        
        locationManager.requestWhenInUseAuthorization()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        // Define the file path to the CountryCities.plist file in the Documents directory
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        
        // Add the plist filename to the documents directory path to obtain an absolute path to the plist filename
        let plistFilePathInDocumentDirectory = documentDirectoryPath + "/carInventory.plist"
        
        // Write the NSMutableDictionary to the CountryCities.plist file in the Documents directory
        make_dict_cars.writeToFile(plistFilePathInDocumentDirectory, atomically: true)
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Define the file path to the CountryCities.plist file in the Documents directory
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        
        // Add the plist filename to the documents directory path to obtain an absolute path to the plist filename
        let plistFilePathInDocumentDirectory = documentDirectoryPath + "/carInventory.plist"
        
        // Write the NSMutableDictionary to the CountryCities.plist file in the Documents directory
        make_dict_cars.writeToFile(plistFilePathInDocumentDirectory, atomically: true)
    }
    
    


}

