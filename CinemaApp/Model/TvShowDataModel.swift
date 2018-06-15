//
//  TvShowDataModel.swift
//  CinemaApp
//
//  Created by administrator on 6/12/18.
//  Copyright © 2018 administrator. All rights reserved.
//

import Foundation

class TvShowDataModel {
    
    var tvShowName : String!
    var tvShowThumbnail : String = ""
    var tvShowDescription : String!
    
    // MARK : initialize tvShowDataModel
    
    init(tvShowName: String, tvShowThumbnail: String, tvShowDescription : String)
    {
        self.tvShowName = tvShowName
        self.tvShowThumbnail = tvShowThumbnail
        self.tvShowDescription = tvShowDescription
    }
}
