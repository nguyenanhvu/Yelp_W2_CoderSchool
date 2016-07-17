//
//  FilterCell.swift
//  Yelp
//
//  Created by Vu Nguyen on 7/15/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FilterCellDelegate {
    optional func filterCell(filterCell: FilterCell, didChangedValue value: Bool )
}

class FilterCell: UITableViewCell {

    @IBOutlet weak var categorySwitch: UISwitch!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var delegate: FilterCellDelegate?
    
    @IBAction func onSwitchChanged(sender: UISwitch) {
        print("Switch changed to state \(categorySwitch.on)")
        delegate?.filterCell?(self, didChangedValue: categorySwitch.on)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
