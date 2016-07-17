//
//  DealCell.swift
//  Yelp
//
//  Created by Vu Nguyen on 7/16/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DealCellDelegate {
    func dealCell(dealCell: DealCell, didUpdatedDealState dealState: Bool)
}

class DealCell: UITableViewCell {

    var delegate: DealCellDelegate?
    
    @IBOutlet weak var dealSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSwitchChanged(sender: UISwitch) {
        
        delegate?.dealCell(self, didUpdatedDealState: dealSwitch.on)
    }
}
