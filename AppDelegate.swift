//
//  AppDelegate.swift
//  gammacontrol
//
//  Created by Tan Thor Jen on 29/8/16.
//  Copyright © 2016 Tan Thor Jen. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var mainWindowController: NSWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        
        if let wc = mainWindowController {
            wc.window?.makeKeyAndOrderFront(sender)
        }
        
        return true;
    }

}



class MyWindowController : NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        
        if let d = NSApp.delegate as? AppDelegate {
            d.mainWindowController = self
        }
    }
}

