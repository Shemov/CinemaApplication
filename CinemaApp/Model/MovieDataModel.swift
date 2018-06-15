//
//  Movie.swift
//  CinemaApp
//
//  Created by administrator on 6/10/18.
//  Copyright © 2018 administrator. All rights reserved.
//

import Foundation

class MovieDataModel {
    
    var movieName : String!
    var movieThumbnail : String = ""
    var movieDescription : String!
    var id : Int!
    var key : String!
    // MARK : initialize movieDataModel
    
    init(movieName: String, movieThumbnail: String, movieDescription : String, id : Int)
    {
        self.movieName = movieName
        self.movieThumbnail = movieThumbnail
        self.movieDescription = movieDescription
        self.id = id
    }
}
