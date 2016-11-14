//
//  MovieDetailController.swift
//  MovieGuide
//
//  Created by Jason Wong on 11/12/16.
//  Copyright © 2016 Jason Wong. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailController: UIViewController {
    
    @IBOutlet weak var backDropImageView: UIImageView!
    
    @IBOutlet weak var tittleLabel: UILabel!
    
    @IBOutlet weak var overViewLabel: UILabel!
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tittleLabel.text = movie?.movieTitle
        self.overViewLabel.text = movie?.movieOverview
        
        if(movie?.movieBackdropPathUrl != nil) {
           // backDropImageView.af_setImageWithURL(URL(string: movie!.movieBackdropPathUrl!)!)
            backDropImageView.af_setImage(withURL: NSURL(string: movie!.movieBackdropPathUrl!)! as URL)
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
