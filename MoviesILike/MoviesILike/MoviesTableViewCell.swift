//
//  MoviesTableViewCell.swift
//  CurrentMovies
//
//  Created by Neel A on 10/29/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet var moviePosterImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var audienceScoreLabel: UILabel!
    @IBOutlet var movieStarsLabel: UILabel!
    @IBOutlet var mpaaRatingRuntimeDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
