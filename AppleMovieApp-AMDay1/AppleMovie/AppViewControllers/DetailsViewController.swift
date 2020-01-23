//
//  DetailsViewController.swift
//  AppleMovie
//
//  Created by Captain on 14/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit
import Kingfisher
class DetailsViewController: UIViewController {

    var getMoviesArrayData = [AppleMoviesData]()
    var movie:AppleMoviesData?

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "Backsegue", sender: IndexPath.self)
    }
    
    @IBOutlet var movieimageview: UIImageView!
    @IBOutlet var languagelabel: UILabel!
    @IBOutlet var votecountlabel: UILabel!
    @IBOutlet var descriptionlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languagelabel.text = "\(movie!.popularity)"
        movieimageview.kf.setImage(with: URL(string: JsonParseData.JsonMoviesData.imageurl + movie!.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
        votecountlabel.text = "\(movie!.vote_count)"
        descriptionlabel.text = movie?.overview
        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
