//
//  TopRatedViewController.swift
//  AppleMovie
//
//  Created by Captain on 14/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit
import Kingfisher
class TopRatedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource{
   
    var getMoviesArrayData = [AppleMoviesData]()
    var movies:AppleMoviesData?
    var positionScroll:CGFloat = 0

    @IBOutlet var populartableview: UITableView!
    @IBOutlet var toprtdcollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populartableview.delegate = self
        populartableview.dataSource = self
        toprtdcollectionView.delegate = self
        toprtdcollectionView.dataSource = self
       // scrollHorizontal()
       // scrollViewDidScroll(scrollView: populartableview)

       
        topratedcollectionvw.JsonMoviesData.JsonURLS(Moviescateogry: "top_rated", page: 2)
        getMoviesArrayData = JsonParseData.JsonMoviesData.MoviesDataArray
        
        jsonparsingfortoprated.JsonMoviesData.JsonURLS(Moviescateogry: "popular", page: 2)
        getMoviesArrayData = JsonParseData.JsonMoviesData.MoviesDataArray
        populartableview.reloadData()
        }
   
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        positionScroll = self.populartableview.contentOffset.y
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.populartableview.contentOffset.y > self.positionScroll || self.populartableview.contentOffset.y < self.positionScroll{
            self.populartableview.isPagingEnabled = true
        } else{
            self.populartableview.isPagingEnabled = false
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getMoviesArrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCollectionViewCell", for: indexPath) as! TopRatedCollectionViewCell
        cell.toprtdImageview.layer.cornerRadius = 12
        cell.toprtdImageview.clipsToBounds = true
        
        let MoviestoShowinCell = getMoviesArrayData[indexPath.row]
        cell.topratedNamelbl.text = MoviestoShowinCell.title
        cell.topratedPopularitylbl.text = String(MoviestoShowinCell.popularity)
        cell.topratedDescriptionlbl.text = MoviestoShowinCell.overview
        cell.topratedvoteavglbl.text = String(MoviestoShowinCell.vote_average)
        cell.topvotecountlbl.text = String(MoviestoShowinCell.vote_count)
        cell.toprtdImageview.kf.setImage(with: URL(string: JsonParseData.JsonMoviesData.imageurl + MoviestoShowinCell.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
 
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //toprateddetails
//        performSegue(withIdentifier: "toprateddetails", sender: indexPath)
//    }
//
    func scrollHorizontal(){
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMoviesArrayData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedTableViewCell", for: indexPath) as! TopRatedTableViewCell
       cell.MVImageView.layer.cornerRadius = 10
        cell.MVImageView.clipsToBounds = true
        let MoviestoShowinCell = getMoviesArrayData[indexPath.row]
        cell.movienamelbl.text = MoviestoShowinCell.title
        cell.popularitylbl.text = String(MoviestoShowinCell.popularity)
        cell.releaseddatelbl.text = MoviestoShowinCell.release_date
        cell.votecountlbl.text = String(MoviestoShowinCell.vote_count)
        cell.MVImageView.kf.setImage(with: URL(string: JsonParseData.JsonMoviesData.imageurl + MoviestoShowinCell.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
        
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "toprateddetails", sender: indexPath)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
