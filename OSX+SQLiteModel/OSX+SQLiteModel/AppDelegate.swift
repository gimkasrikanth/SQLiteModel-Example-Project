//
//  AppDelegate.swift
//  OSX+SQLiteModel
//
//  Created by Jeff Hurray on 4/24/16.
//  Copyright © 2016 jhurray. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        try! Node.createTable()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

