//
//  LogsTableViewController.swift
//  EasyLogging
//
//  Created by Владислав  on 07.10.16.
//  Copyright © 2016 Zazmic. All rights reserved.
//

import Cocoa

class LogsTableViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate, DeleteCellDelegate {

    @IBOutlet weak var tableView: NSTableView!
    var events = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.fetchEvents(events: &self.events)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.addObservers()
        
        self.tableView.register(NSNib.init(nibNamed: "DeleteCell", bundle: nil), forIdentifier: "DeleteID")
    }
    
    //MARK: - Private
    
    private func addObservers()  {
        self.createObserver(withSelector: #selector(LogsTableViewController.updateLogs(notification:)), notificationName: UpdateLogsNotification)
        self.createObserver(withSelector: #selector(LogsTableViewController.clearLogs(notification:)), notificationName: ClearLogsNotification)
    }
    
    private func createObserver(withSelector selector: Selector, notificationName name: String) {
        NotificationCenter.default.addObserver(self,
                                               selector: selector,
                                               name: NSNotification.Name(rawValue: name),
                                               object: nil)
    }
    
    //MARK: - <NSTableViewDataSource>

    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text:String = ""
        var cellIdentifier: String = ""
        
        if tableColumn == tableView.tableColumns[0] {
            text = String(describing: row + 1) + ")"
            cellIdentifier = "EventNumberID"
        } else if tableColumn == tableView.tableColumns[1] {
            let event = self.events[row]
            let projectName = event.value(forKey: "projectName")
            text = projectName as! String
            cellIdentifier = "ProjectNameID"
        } else if tableColumn == tableView.tableColumns[2] {
            let event = self.events[row]
            let taskName = event.value(forKey: "taskName")
            text = taskName as! String
            cellIdentifier = "TaskNameID"
        } else if tableColumn == tableView.tableColumns[3] {
            let event = self.events[row]
            let taskDescription = event.value(forKey: "taskDescription")
            text = taskDescription as! String
            cellIdentifier = "TaskDescriptionID"
        } else if tableColumn == tableView.tableColumns[4] {
            let event = self.events[row]
            let timeSpent = Date.readableDate(date:  event.value(forKey: "startTime") as! Date)
            text = timeSpent
            cellIdentifier = "StartTimeID"
        }
        else if tableColumn == tableView.tableColumns[5] {
            let event = self.events[row]
            let timeSpent = event.value(forKey: "timeSpent")
            timeSpent != nil ? (text = timeSpent as! String) : (text = "Undefined")
            cellIdentifier = "TimeSpentID"
        }
        else if tableColumn == tableView.tableColumns[6] {
            cellIdentifier = "DeleteID"
            if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? DeleteCell {
                cell.delegate = self
                cell.selectedIndex = row
                cell.textField?.stringValue = text
                return cell
            }
        }
        
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
    
    //MARK: - <DeleteCellDelegate>

    func cellDidTapDeleteAction(sender: DeleteCell, atIndex index: Int) {
        print("Delete row at index: \(index)")
        CoreDataManager.deleteEvent(FromEvents: &self.events, atIndex: index)
        self.tableView.removeRows(at: [index], withAnimation: .effectFade)
    }
    
    //MARK: - <NotificationCenter>
    
    func updateLogs(notification: Notification) {
        CoreDataManager.fetchEvents(events: &self.events)
        self.tableView.reloadData()
    }
    
    func clearLogs(notification: Notification)  {
        CoreDataManager.clear(allEvents: &self.events)
        self.tableView.reloadData()
    }
    
    //MARK: - Deallocation
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}
