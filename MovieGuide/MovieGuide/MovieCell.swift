//
//  MovieCell.swift
//  MovieGuide
//
//  Created by Jason Wong on 11/4/16.
//  Copyright © 2016 Jason Wong. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var tittleLabel: UILabel!
    
    var movie : Movie! {
        didSet {
            tittleLabel.text = movie.movieTitle
            
            
            if let moviepath = movie.moviePosterUrl {
                posterImageView.af_setImage(withURL: NSURL(string: moviepath)! as URL)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
