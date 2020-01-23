//
//  UpComingViewController.swift
//  AppleMovie
//
//  Created by Captain on 15/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import UIKit
import Kingfisher
class UpComingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var getMoviesArrayData = [AppleMoviesData]()

    @IBOutlet var upcomingtableV: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        upcomingtableV.delegate = self
        upcomingtableV.dataSource = self
        Upcoming.JsonMoviesData.JsonURLS(Moviescateogry: "upcoming", page: 2)
        getMoviesArrayData = Upcoming.JsonMoviesData.MoviesDataArray
        //upcomingtableV.reloadData()
        print(getMoviesArrayData)
        // Do any additional setup after loading the view.
    }

//    func getImage(from string: String) -> UIImage? {
//        guard let url = URL(string: string) else {
//            return nil
//        }
//        var image: UIImage? = nil
//        do {
//            let data = try Data(contentsOf: url, options: [])
//            image = UIImage(data: data)
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//        return image
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMoviesArrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as! UpcomingTableViewCell
        cell.upcomingImgView.layer.cornerRadius = 10
        cell.upcomingImgView.clipsToBounds = true
        let MoviestoShowinCell = getMoviesArrayData[indexPath.row]
        cell.mvnameUpcm.text = MoviestoShowinCell.title
        cell.releasedateupcm.text = MoviestoShowinCell.release_date
        cell.popularityupcm.text = String(MoviestoShowinCell.popularity)
        cell.votecountupcm.text = String(MoviestoShowinCell.vote_count)
     cell.upcomingImgView.kf.setImage(with: URL(string: JsonParseData.JsonMoviesData.imageurl + MoviestoShowinCell.poster_path), placeholder: nil, options: [], progressBlock: nil, completionHandler: nil)
       // cell.upcomingImgView.kf.setImage(with: URL(string: JsonParseData.JsonMoviesData.imageurl + MoviestoShowinCell.poster_path), placeholder: #imageLiteral(resourceName: "placeholder"))

        //        let string = "https://image.tmdb.org/t/p/w200/zPQzLZnfVw9fbXyxxglyOsmQBlu.jpg"
//        if let image = getImage(from: string){
//            cell.upcomingImgView.image = image
//        }

        return cell
    }
}
