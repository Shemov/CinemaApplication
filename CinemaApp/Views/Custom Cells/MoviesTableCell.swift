//
//  MoviesTableCell.swift
//  CinemaApp
//
//  Created by administrator on 6/10/18.
//  Copyright © 2018 administrator. All rights reserved.
//

import Foundation
import UIKit

class MoviesTableCell : UITableViewCell{
    
    var movieImageView : UIImageView!
    var movieTitleLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented&quot")
        
    }
    
    // MARK: Setup views
    
    func setupViews(){
        
        movieImageView = UIImageView()
        movieImageView.contentMode = .scaleAspectFit
        
        movieTitleLabel = UILabel()
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        movieTitleLabel.numberOfLines = 0
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleLabel)
        
    }
    
    // MARK: Setup views constraints
    
    func setupConstraints(){
        
        movieImageView.snp.makeConstraints{make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.width.equalTo(100)
        }
        movieTitleLabel.snp.makeConstraints{make in
            make.top.equalTo(contentView.frame.size.width).offset(10)
            make.left.equalTo(movieImageView.snp.right).offset(15)
            make.right.equalTo(contentView).offset(-10)
        }
    }
}
