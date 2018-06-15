//
//  MainMovieCell.swift
////  CinemaApp
////
////  Created by administrator on 6/10/18.
////  Copyright © 2018 administrator. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class MainMovieCell : UICollectionViewCell{
//
//    var movieImageView : UIImageView!
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.black.cgColor
//        setupViews()
//        setupConstraints()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupViews(){
//        movieImageView = UIImageView()
//        movieImageView.contentMode = .scaleAspectFit
//        movieImageView.image = #imageLiteral(resourceName: "me")
//
//        contentView.addSubview(movieImageView)
//    }
//
//    func setupConstraints(){
//
//        movieImageView.snp.makeConstraints { make in
//        make.edges.equalTo(contentView)
//        }
//    }
//}
