//
//  MovieCollectionVIewLayout.swift
//  CinemaApp
//
//  Created by administrator on 6/7/18.
//  Copyright © 2018 administrator. All rights reserved.
//

import Foundation
import UIKit

class MovieCoolectionViewLayout : UICollectionViewFlowLayout{
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 5
        minimumLineSpacing = 5
        scrollDirection = .vertical
    }
    
    override var itemSize: CGSize {
        set {}
        get {
     //       let numberOfColumns: CGFloat = 5
            var itemWidth : CGFloat!
         //   var itemMultiplier : CGFloat!
            //itemWidth = (self.collectionView!.frame.width - (numberOfColumns - 1)*5) / numberOfColumns
            itemWidth = (self.collectionView!.frame.width / 2) - 10
            return CGSize(width: itemWidth, height: itemWidth)

        }}}
//            if UIDevice.current.orientation.isLandscape {
//                if UIDevice.current.modelName.contains("iPad") {
//                    itemWidth = (self.collectionView!.frame.height - 10) / itemMultiplier
//                } else {
//                    itemWidth = (self.collectionView!.frame.height - 5) / itemMultiplier
//                }
//            } else {
//                itemWidth = (self.collectionView!.frame.width - (numberOfColumns - 1)*5) / numberOfColumns
//            }
//        }
