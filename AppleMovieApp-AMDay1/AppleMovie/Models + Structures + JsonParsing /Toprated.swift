//
//  Toprated.swift
//  AppleMovie
//
//  Created by Captain on 15/01/20.
//  Copyright © 2020 Captain. All rights reserved.
//

import Foundation

struct TopRatedMovies: Codable
{
    var title:String
    var overview:String
    var release_date:String
    var vote_average:Double
    var poster_path:String
    var id:Int
}


