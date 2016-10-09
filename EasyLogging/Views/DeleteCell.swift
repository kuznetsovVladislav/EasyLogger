//
//  DeleteCell.swift
//  EasyLogging
//
//  Created by Владислав  on 08.10.16.
//  Copyright © 2016 Zazmic. All rights reserved.
//

import Cocoa

protocol DeleteCellDelegate: class {
    func cellDidTapDeleteAction(sender: DeleteCell, atIndex index: Int)
}

class DeleteCell: NSTableCellView {

    weak var delegate: DeleteCellDelegate?
    var selectedIndex: Int?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    @IBAction func deleteAction(_ sender: AnyObject) {
        self.delegate?.cellDidTapDeleteAction(sender: self, atIndex: selectedIndex!)
    }
    
}
