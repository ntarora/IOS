//
//  MyGenreTableViewCell.swift
//  MoviesILike
//
//  Created by Neel A on 11/17/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit

class MyGenreTableViewCell: UITableViewCell {

    @IBOutlet var ratingImageView: UIImageView!
    @IBOutlet var movieNameLabel: UILabel!
    @IBOutlet var actorsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
