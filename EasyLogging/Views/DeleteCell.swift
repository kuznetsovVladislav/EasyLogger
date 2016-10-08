//
//  DeleteCell.swift
//  EasyLogging
//
//  Created by Владислав  on 08.10.16.
//  Copyright © 2016 Zazmic. All rights reserved.
//

import Cocoa

let DeleteButtonDidTapNotification = "DeleteButtonDidTapNotification"

class DeleteCell: NSTableCellView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    @IBAction func deleteAction(_ sender: AnyObject) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DeleteButtonDidTapNotification), object: nil)
    }
    
}
