//
//  ActionViewController.swift
//  EasyLogging
//
//  Created by Владислав  on 06.10.16.
//  Copyright © 2016 Zazmic. All rights reserved.
//

import Cocoa

class ActionViewController: NSViewController {
    
    @IBOutlet weak var projectNameTextField: NSTextField!
    @IBOutlet weak var taskNameTextField: NSTextField!
    @IBOutlet weak var taskDescriptionTextField: NSTextField!
    @IBOutlet weak var loggingButton: NSButton!
    
    var events = [NSManagedObject]()
    var isLogging: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.projectNameTextField.becomeFirstResponder()
    }
    
    //MARK: - Private 
    
    private func printAttribute(withStartText startText: String, withEvent event: NSManagedObject, forKey attributeKey: String) {
        let value = event.value(forKey: attributeKey)
        if value is String {
            let stringValue = value as! String
            !stringValue.isEmpty ? print("- \(startText): \(stringValue)") : print("- \(startText): Undefined")
        } else {
            value != nil ? print("- \(startText): \(value!)") : print("- \(startText): Undefined")
        }
    }
    
    //MARK: - Actions
    
    @IBAction func loggingAction(_ sender: AnyObject) {
        self.isLogging ? self.stopLoggingAction(sender) : self.startLoggingAction(sender)
        self.isLogging ? (self.isLogging = false) : (self.isLogging = true)
    }
    
    func startLoggingAction(_ sender: AnyObject) {
        let startTime = Date()
        let projectName = self.projectNameTextField.stringValue
        let taskName = self.taskNameTextField.stringValue
        let taskDescription = self.taskDescriptionTextField.stringValue
        self.loggingButton.title = "Stop Logging"
        CoreDataManager.addLogEvent(toEvents: &self.events, withProjectName: projectName, taskName: taskName, taskDescription: taskDescription, startTime: startTime)
    }
    
    func stopLoggingAction(_ sender: AnyObject) {
        let stopTime = Date()
        self.loggingButton.title = "Start Logging"
        let textFields = [self.projectNameTextField, self.taskNameTextField, self.taskDescriptionTextField] as [NSTextField]
        for textField in textFields {
            textField.stringValue = ""
            textField.resignFirstResponder()
        }
        CoreDataManager.addStopTime(toEvents: &self.events, withStopTime: stopTime)
    }
    
    @IBAction func showEventsAction(_ sender: AnyObject) {
        CoreDataManager.fetchEvents(events: &self.events)
        
        #if DEBUG
        for (index, event) in self.events.enumerated() {
            print("\(index + 1))Event")
            printAttribute(withStartText: "Project name", withEvent: event, forKey: "projectName")
            printAttribute(withStartText: "Task name", withEvent: event, forKey: "taskName")
            printAttribute(withStartText: "Task description", withEvent: event, forKey: "taskDescription")
            printAttribute(withStartText: "Start Time", withEvent: event, forKey: "startTime")
            printAttribute(withStartText: "Stop Time", withEvent: event, forKey: "stopTime")
            printAttribute(withStartText: "Time spent", withEvent: event, forKey: "timeSpent")
            print("\n")
        }
        print("---------------------------------\n")
        #endif
    }
    
    @IBAction func clearCoreDataAction(_ sender: AnyObject) {
        CoreDataManager.clear(allEvents: &self.events)
        self.isLogging = false
        self.loggingButton.title = "Start Logging"
    }

}
