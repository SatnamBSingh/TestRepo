//
//  Movies.swift
//  AppleMovie
//
//  Created by Captain on 14/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import Foundation

struct AppleMoviesData: Codable
{
    var title:String
    var overview:String
    var release_date:String
    var vote_average:Double
    var poster_path:String
    var id:Int
    var popularity:Double
    var vote_count:Int
}
//var id:Int
//var vote_count:Int
//var vote_average:Double
//var popularity:Double
//var title:String
//var overview:String
//var release_date:String
//var poster_path:String
//var original_language:String
//var backdrop_path:String
