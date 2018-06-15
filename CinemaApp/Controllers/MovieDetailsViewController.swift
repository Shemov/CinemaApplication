//
//  MovieDetailsViewController.swift
//  CinemaApp
//
//  Created by administrator on 6/10/18.
//  Copyright © 2018 administrator. All rights reserved.
//

import UIKit
import SnapKit
import AFNetworking
import Alamofire
import AVKit

class MovieDetailsViewController: UIViewController {
    
    var trail_URL = "https://api.themoviedb.org/3/movie/"
    var trailEndPoint_URL = "/videos?api_key=b211195cc6271ed0d062ba1d5766e474"
    let base_Image_URL = "https://image.tmdb.org/t/p/w500/"
    var youtubeURL = "https://www.youtube.com/watch?v="
    
    var movie : MovieDataModel!
    var tvShow : TvShowDataModel!
    var type : String!
    var movieDescription : UILabel!
    var movieImage : UIImageView!
    var videoPlayer : UIWebView!
    
    init(data : Any, type : String) {
        print(movie)
        self.type = type
        super.init(nibName : nil, bundle : nil)
        if type == "movie" {
            self.movie = data as! MovieDataModel
        } else if type == "show"{
            self.tvShow = data as! TvShowDataModel
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == "movie" {
            setupViews()
            setupVidePlayer()
            setupPlayerConstraints()
            self.title = movie.movieName
            getTrailer(url: trail_URL + "\(movie.id!)" + "\(trailEndPoint_URL)")
        } else if type == "show" {
            setupViewsTvShows()
            self.title = tvShow.tvShowName
        }
        setupConstraints()
        self.view.backgroundColor = UIColor.white
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupViews(){
        movieImage = UIImageView()
        let imageURl = URL(string: self.base_Image_URL + movie.movieThumbnail)
        movieImage.setImageWith(imageURl!)
        
        movieDescription = UILabel()
        movieDescription.numberOfLines = 0
        movieDescription.textAlignment = .center
        movieDescription.font = UIFont.systemFont(ofSize: 15)
        movieDescription.text = movie.movieDescription
        
        self.view.addSubview(movieDescription)
        self.view.addSubview(movieImage)
    }
    
    func setupConstraints(){
        movieImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(75)
            make.width.equalTo(self.view.frame.size.width).dividedBy(1.5)
            make.height.equalTo(400).priority(1000)
        }
        
        movieDescription.snp.makeConstraints { (make) in
            make.top.equalTo(movieImage.snp.bottom).offset(5)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.bottom.equalTo(self.view).offset(-15)
        }
        
    }
    
    func setupVidePlayer(){
        videoPlayer = UIWebView()
        videoPlayer.isHidden = true
        videoPlayer.delegate = self
        videoPlayer.backgroundColor = UIColor.black
        
        self.view.addSubview(videoPlayer)
    }
    
    func setupPlayerConstraints(){
        videoPlayer.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(75)
            make.width.equalTo(self.view.frame.size.width).dividedBy(1.5)
            make.height.equalTo(400).priority(800)
        }
    }
    
    func setupViewsTvShows(){
        
        movieImage = UIImageView()
        movieImage.contentMode = .scaleAspectFit
        let imageURl = URL(string: self.base_Image_URL + tvShow.tvShowThumbnail)
        movieImage.setImageWith(imageURl!)
        
        movieDescription = UILabel()
        movieDescription.numberOfLines = 0
        movieDescription.font = UIFont.systemFont(ofSize: 15)
        movieDescription.textAlignment = .center
        movieDescription.text = tvShow.tvShowDescription
        
        self.view.addSubview(movieDescription)
        self.view.addSubview(movieImage)
    }
    
    func getVIdeo(movieid : String){
        let url = URL(string: "https://www.youtube.com/watch?v=\(movieid)")
        videoPlayer.loadRequest(URLRequest(url: url!))
        print(url!)
    }
    
    func getTrailer(url : String){
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                print(response.result.value!)
                let trailerJSON = response.result.value! as! [String:Any]
                print(trailerJSON)
                let movieResults = trailerJSON["results"] as! [Any]
                print(movieResults)
                let movieKey = movieResults[0] as! [String:Any]
                let keyValue = movieKey["key"] as! String
                
                self.getVIdeo(movieid: "\(keyValue)")
                
            } else{
                print("Error \(String(describing: response.result.error))")
            }
            
        }}
}

extension MovieDetailsViewController : UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        videoPlayer.isHidden = false
    }
}
