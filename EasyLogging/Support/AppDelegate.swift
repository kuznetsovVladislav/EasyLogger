//
//  AppDelegate.swift
//  EasyLogging
//
//  Created by Владислав  on 06.10.16.
//  Copyright © 2016 Zazmic. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let popover = NSPopover()
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let menu = NSMenu()

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setUpStatusBar()
    }
    
    func setUpStatusBar() {
        if let button = statusItem.button {
            button.image = NSImage(named: "menu-item")
            button.action = #selector(AppDelegate.togglePopover(sender:))
        }
        self.popover.contentViewController = ActionViewController(nibName: "ActionViewController", bundle: nil)
        self.popover.behavior = .transient
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
    }
    
    func togglePopover(sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        CoreDataStack.shared.saveContext()
        if popover.isShown {
            closePopover(sender: nil)
        }
    }


}

