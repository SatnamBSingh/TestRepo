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
class NowPlayingVc: UIViewController,UITableViewDelegate,UITableViewDataSource{
    

    var getMoviesArrayData = [AppleMoviesData]()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var movieDescription:String!
    var pagenumber = 0
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMoviesArrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "NowPalyingTableViewCell", for: indexPath) as! NowPalyingTableViewCell
        cell.layer.cornerRadius = 30
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOpacity = 0.23
        cell.layer.shadowRadius = 4
        
        let MoviestoShowinCell = getMoviesArrayData[indexPath.row]
        cell.moviename.text = MoviestoShowinCell.title
        cell.descriptionlabel.text = MoviestoShowinCell.overview
        cell.releasedlabel.text = MoviestoShowinCell.release_date
        cell.ratinglabel.text = String(MoviestoShowinCell.vote_average)
        cell.votinglabel.text = String(MoviestoShowinCell.vote_count)
        // cell.MovieImageView.kf.setImage(with: URL(string: JsonParseData.JsonMoviesData.imageurl + MoviestoShowinCell.poster_path), placeholder: #imageLiteral(resourceName: "placeholder"))
        cell.MovieImageView.kf.setImage(with: URL(string: JsonParseData.JsonMoviesData.imageurl + MoviestoShowinCell.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.global().async {
            if indexPath.row == self.getMoviesArrayData.count-1 {
                self.pagenumber = self.pagenumber + 1
                self.getsSearchMovies(pagenumber: self.pagenumber, moviescateogry: "now_playing")
            }
        }
    }

   func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentcell = tableView.cellForRow(at: indexPath) as! NowPalyingTableViewCell
        let movie = getMoviesArrayData[indexPath.row]
        movieDescription = currentcell.descriptionlabel.text
        performSegue(withIdentifier: "details", sender: movie)

    }
    
    @IBOutlet var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        pagenumber = 1
        getsSearchMovies(pagenumber: pagenumber, moviescateogry: "now_playing")
        // JsonParseData.JsonMoviesData.JsonURLS(Moviescateogry: "now_playing", page: self.pagenumber)
        //        getMoviesArrayData = JsonParseData.JsonMoviesData.MoviesDataArray
        print(getMoviesArrayData)
    }
    
    func getnowplayingMovies(moviescateogry: String, pagenumber: Int){
        JsonParseData.JsonMoviesData.JsonURLS(Moviescateogry: moviescateogry, page: pagenumber)
        self.getMoviesArrayData = JsonParseData.JsonMoviesData.MoviesDataArray
        DispatchQueue.main.sync {
            self.tableview.reloadData()
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
            self.tableview.reloadData()
        }
    }
    
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
    

