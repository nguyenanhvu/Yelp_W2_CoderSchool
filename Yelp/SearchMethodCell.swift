//
//  SearchMethodCell.swift
//  Yelp
//
//  Created by Vu Nguyen on 7/16/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SearchMethodCellDelegate{
    optional func searchMethodCell(searchMethodCell: SearchMethodCell, onUpdatedSelectedSeg indexSeg: Int)
}

class SearchMethodCell: UITableViewCell {
    
    var delegate: SearchMethodCellDelegate?

    @IBOutlet weak var methodSegment: UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onSelectedChanged(sender: UISegmentedControl) {
        delegate?.searchMethodCell!(self, onUpdatedSelectedSeg: methodSegment.selectedSegmentIndex)
    }
    

}
