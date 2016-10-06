//
//  CoreDataManager.swift
//  EasyLogging
//
//  Created by Владислав  on 06.10.16.
//  Copyright © 2016 Zazmic. All rights reserved.
//

import Cocoa

class CoreDataManager: NSObject {
    
    class func addLogEvent(toEvents events: inout [NSManagedObject], withProjectName projectName: String, taskName: String, taskDescription: String, startTime: Date) {
        
        let managedContext = CoreDataStack.shared.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Event", in: managedContext)
        let event = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        event.setValue(projectName, forKey: "projectName")
        event.setValue(taskName, forKey: "taskName")
        event.setValue(taskDescription, forKey: "taskDescription")
        event.setValue(startTime, forKey: "startTime")
        
        do {
            try managedContext.save()
            events.append(event)
        } catch let error as NSError {
            print("Couldn't save to CoreData. Error: \(error);\(error.userInfo)")
        }
    }
    
    class func addStopTime(toEvents events: inout [NSManagedObject], withStopTime stopTime: Date) {
        
        let managedContext = CoreDataStack.shared.managedObjectContext
        
        let lastEvent = events.last! as NSManagedObject
        let startTime = lastEvent.value(forKey: "startTime") as! Date
        let timeSpent = Date.timeSpent(fromDate: startTime, toDate: stopTime)
        
        lastEvent.setValue(stopTime, forKey: "stopTime")
        lastEvent.setValue(timeSpent, forKey: "timeSpent")
    
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Couldn't save to CoreData. Error: \(error);\(error.userInfo)")
        }

    }
    
    class func fetchEvents(events: inout [NSManagedObject]) {
        
        let managedContext = CoreDataStack.shared.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            events = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    class func clear(allEvents events: inout [NSManagedObject]) {
     
        let managedContext = CoreDataStack.shared.managedObjectContext
        let coord = managedContext.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord?.execute(deleteRequest, with: managedContext)
        } catch let error as NSError {
            debugPrint(error)
        }
        events.removeAll()
    }

    
    

}
