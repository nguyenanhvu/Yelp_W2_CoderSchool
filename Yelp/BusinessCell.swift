//
//  BusinessCell.swift
//  Yelp
//
//  Created by Vu Nguyen on 7/13/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var catagoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var nameBusinessLabel: UILabel!
    @IBOutlet weak var businessImage: UIImageView!
    
    var business: Business!{
        didSet{
            businessImage.setImageWithURL(business.imageURL!)
            nameBusinessLabel.text = business.name
            nameBusinessLabel.sizeToFit()
            addressLabel.text = business.address
            ratingImage.setImageWithURL(business.ratingImageURL!)
            catagoryLabel.text = business.categories
            distanceLabel.text = business.distance

            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        businessImage.layer.cornerRadius = 8
        businessImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
