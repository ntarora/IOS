//
//  CarTableViewCell.swift
//  iCarSales
//
//  Created by Neel A on 12/9/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {


    @IBOutlet var carTrimLabel: UILabel!
    @IBOutlet var priceLael: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
