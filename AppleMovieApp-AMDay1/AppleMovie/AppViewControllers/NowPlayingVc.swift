//
//  NowPlayingVc.swift
//  AppleMovie
//
//  Created by Captain on 13/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher
class NowPlayingVc: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    

    @IBOutlet weak var collectionviewnp: UICollectionView!
    var getMoviesArrayData = [AppleMoviesData]()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var movieDescription:String!
    var pagenumber = 1
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getMoviesArrayData.count

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowplayingCollectionViewCell", for: indexPath) as! NowplayingCollectionViewCell
        cell.layer.cornerRadius = 30
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 5.0
        
        let MoviestoShowinCell = getMoviesArrayData[indexPath.row]
        cell.movienamelabel.text = MoviestoShowinCell.title
        cell.moviedescriptionlabel.text = MoviestoShowinCell.overview
        cell.releaselabel.text = MoviestoShowinCell.release_date
        cell.ratinglabel.text = String(MoviestoShowinCell.vote_average)
        cell.votinglabel.text = String(MoviestoShowinCell.vote_count)
        cell.movieimageview.kf.setImage(with: URL(string: JsonParseData.JsonMoviesData.imageurl + MoviestoShowinCell.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.global().async {
            if indexPath.row == self.getMoviesArrayData.count {
                self.pagenumber = self.pagenumber + 1
                self.getsSearchMovies(pagenumber: self.pagenumber, moviescateogry: "now_playing")
                DispatchQueue.main.async {
                    self.collectionviewnp.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentcell = collectionviewnp.cellForItem(at: indexPath) as! NowplayingCollectionViewCell
        let movie = getMoviesArrayData[indexPath.row]
        movieDescription = currentcell.moviedescriptionlabel.text
        performSegue(withIdentifier: "details", sender: movie)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionviewnp.delegate = self
        collectionviewnp.dataSource = self
        pagenumber = 1
        getsSearchMovies(pagenumber: pagenumber, moviescateogry: "now_playing")
        print(getMoviesArrayData)
    }
    
    func getnowplayingMovies(moviescateogry: String, pagenumber: Int){
        JsonParseData.JsonMoviesData.JsonURLS(Moviescateogry: moviescateogry, page: pagenumber)
        self.getMoviesArrayData = JsonParseData.JsonMoviesData.MoviesDataArray
        DispatchQueue.main.sync {
            self.collectionviewnp.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "details") {
            guard let movie  = sender as? AppleMoviesData else{
                return
            }
            let detailsvc =  segue.destination as! DetailsViewController
            detailsvc.movie = movie
        }
    }
    func getsSearchMovies(pagenumber: Int, moviescateogry: String){
        
        JsonParseData.JsonMoviesData.JsonURLS(Moviescateogry: moviescateogry, page: pagenumber)
        getMoviesArrayData = JsonParseData.JsonMoviesData.MoviesDataArray
        DispatchQueue.main.async {
            self.collectionviewnp.reloadData()
        }
    }
    
    
    //For Displaying Cateogry of movies
//    enum Cateogry: CaseIterable{
//        case NowPlaying
//        case TopRated
//        case Popular
//        case UpComing
//    }
//
//    var selectedCateogry = Cateogry.NowPlaying
//    selectedCateogry = .NowPalying
//    switch selectedCateogry{
    //    case .NowPlaying:
//    }
//
    
    //Insert into coredata
    func InsertData(){
        let context = delegate.persistentContainer.viewContext
        let moviObj:NSObject = NSEntityDescription.insertNewObject(forEntityName: "AppleMovies", into: context)
        // moviObj.setValue(self.orginal.text, forKey: "AppleMovies")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppleMovies")
        do
        {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                let populrty = data.value(forKey: "popularity") as! Double
                let votecnt = String(data.value(forKey: "vote_count") as! Double)
                let orgTitle = data.value(forKey: "original_title") as! String
                let orgLang = data.value(forKey: "original_language") as! String
                let ids = data.value(forKey: "id") as! Double
                let img = data.value(forKey: "poster_path") as! String
            }
            
            try context.save()
            print(context)
            readFromCoreData()
        }
        catch
        {
            print("insertion: successful")
        }
    }

    }
    
    //coredata function
    func readFromCoreData()
    {
        let delegate = UIApplication.shared.delegate as! AppDelegate

        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AppleMovies")
        do
        {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                let populrty = data.value(forKey: "popularity") as! Double
                let votecnt = String(data.value(forKey: "vote_count") as! Double)
                let orgTitle = data.value(forKey: "original_title") as! String
                let orgLang = data.value(forKey: "original_language") as! String
                let ids = data.value(forKey: "id") as! Double
                let img = data.value(forKey: "poster_path") as! String
            }
//            if moviesdata.count > 0
//            {
//             //   UITableView.reloadData()
//            }
        }
        catch
        {
            
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

