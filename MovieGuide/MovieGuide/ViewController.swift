//
//  ViewController.swift
//  MovieGuide
//
//  Created by Jason Wong on 11/2/16.
//  Copyright © 2016 Jason Wong. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import Realm

let realmObject = try! Realm()

let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie]? = []
    
    var endpoint = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Realm db path: DEBUG
        print(Realm.Configuration.defaultConfiguration.description)
        
//        let dbMovies = realmObject.objects(Movie.self)
//        
//        if dbMovies.count > 0 {
//            print("Found movies in DB")
//            var newMoviesArray = [Movie]()
//            for movie in dbMovies {
//                newMoviesArray.append(movie)
//            }
//            movies = newMoviesArray
//        } else {
//            //make API call and save data in the realm db
//            makeAPICall()
//        }
        makeAPICall()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie = movies![indexPath.row]
        
        return cell
    }
    
    func makeAPICall() {
        Alamofire.request("https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)",method:.get).responseJSON { response in
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                if let status_code = JSON["status_code"] as? Int{
                    print("ERROR: Unable to hit the API with status code: \(status_code)")
                    print("Got status message: \(JSON["status_message"] as! String)")
                }
                else{
                    print("Connection to API successful!")
                    print(JSON["results"] as Any)
                    self.movies = Movie.movies(array: (JSON["results"] as? [NSDictionary])!)
                    self.tableView.reloadData()
                }
                
            }
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let movie = movies![indexPath!.row]
        
        let movieController = segue.destination as! MovieDetailController
        
        movieController.movie = movie
    }

}

