//
//  MainViewController.swift
//  CinemaApp
//
//  Created by administrator on 6/10/18.
//  Copyright © 2018 administrator. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController {
    
    let api_Key = "b211195cc6271ed0d062ba1d5766e474"
    let base_URL = "https://api.themoviedb.org/3/movie/popular?api_key=b211195cc6271ed0d062ba1d5766e474&language=en-US&page=1"
    let base_Image_URL = "https://image.tmdb.org/t/p/w500/"
    let base_TVShows_URL = "https://api.themoviedb.org/3/tv/popular?api_key=b211195cc6271ed0d062ba1d5766e474&language=en-US&page=1"
    
    var selected = 0
    var filterMovies = [MovieDataModel]()
    var filteredTvShows = [TvShowDataModel]()
    var allmovies = [MovieDataModel]()
    var allTvShows = [TvShowDataModel]()
    
    var movieTableView : UITableView!
    var segmentController : UISegmentedControl!
    let items = ["Movies", "TVShows"]
    var movieSearchBar : UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovieData(url : base_URL)
        getTVShowsData(url: base_TVShows_URL)
        setupViews()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.movieTableView.indexPathForSelectedRow{
            self.movieTableView.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK : Setup the views
    
    func setupViews(){
        segmentController = UISegmentedControl(items: items)
        segmentController.selectedSegmentIndex = 0
        segmentController.selectedSegmentIndex = self.selected
        segmentController.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width/2, height: 0)
        segmentController.addTarget(self, action: #selector(changeSegment), for: .valueChanged)
        
        // Style the Segmented Control
        
        segmentController.layer.cornerRadius = 8.0  
        segmentController.backgroundColor = UIColor.white
        segmentController.tintColor = UIColor.black
        
        movieSearchBar = UISearchBar()
        movieSearchBar.placeholder = "Search movie"
        movieSearchBar.sizeToFit()
        movieSearchBar.isTranslucent = false
        movieSearchBar.delegate = self
        
        movieTableView = UITableView()
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.register(MoviesTableCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(segmentController)
        movieTableView.tableHeaderView = movieSearchBar
        self.view.addSubview(movieTableView)
        
    }
    
    // MARK : Setup the views constraints
    
    func setupConstraints(){
        segmentController.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(100).priority(700)
            make.centerX.equalTo(self.view)
            make.height.equalTo(50)
        }
        
        movieTableView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentController.snp.bottom).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.right.bottom.equalTo(self.view).offset(-20)
        }
        
    }
    
    // MARK: LANDSCAPE : Example how can be done in landscape
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if fromInterfaceOrientation == UIInterfaceOrientation.portrait {
            constraintsLandscape()
            setupConstraints()
        } else {
            constraintsPortrait()
            setupConstraints()
        }
    }
    
    // MARK : Remake views constraints
    
    func constraintsPortrait(){
        segmentController.snp.remakeConstraints { (make) in
            make.top.equalTo(self.view).offset(100)
        }
    }
    
    func constraintsLandscape(){
        segmentController.snp.remakeConstraints { (make) in
            make.top.equalTo(self.view).offset(50)
        }
    }
    
    //MARK : Change Segment
    
    @objc func changeSegment(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selected = 0
            movieTableView.reloadData()
        case 1:
            selected = 1
            movieTableView.reloadData()
        default:
            break
        }
    }
    
    // MARK : UIAlert
    
    func showAlert() {
        let alert = UIAlertController(title: "No Internet connection", message: "Please check your Internet connection and try again ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in}))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK : Networking
    
    // Get all movies
    func getMovieData(url : String){
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                print(response.result.value!)
                let movieJSON = response.result.value! as! [String:Any]
                let movieResults = movieJSON["results"] as! [[String:Any]]
                for movie in movieResults{
                    self.allmovies.append(MovieDataModel(movieName: movie["title"] as! String, movieThumbnail: movie["poster_path"] as! String, movieDescription: movie["overview"] as! String, id: movie["id"] as! Int))
                }
                self.allmovies.removeLast(10)
                self.filterMovies = self.allmovies
                self.movieTableView.reloadData()
            } else{
                self.showAlert()
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    // get tvShows
    func getTVShowsData(url : String){
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                let tvShowsJSON = response.result.value! as! [String:Any]
                let tvShowsResults = tvShowsJSON["results"] as! [[String:Any]]
                for tvShow in tvShowsResults{
                    self.allTvShows.append(TvShowDataModel(tvShowName: tvShow["name"] as! String, tvShowThumbnail: tvShow["poster_path"] as! String, tvShowDescription: tvShow["overview"] as! String))
                }
                self.allTvShows.removeLast(10)
                self.filteredTvShows = self.allTvShows
                self.movieTableView.reloadData()
                
            } else{
                self.showAlert()
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
}

// MARK : SearchBarDelegate

extension MainViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if selected == 0 && searchText != "" && searchText.count >= 3 {
            segmentController.isHidden = true
            filterMovies = allmovies.filter({movie -> Bool in
                movie.movieName.lowercased().contains(searchText.lowercased())
            })
            movieTableView.reloadData()
        } else if selected == 1 && searchText != "" && searchText.count >= 3 {
            segmentController.isHidden = true
            filteredTvShows = allTvShows.filter({tvShow -> Bool in
                tvShow.tvShowName.lowercased().contains(searchText.lowercased())
            })
            movieTableView.reloadData()
        } else{
            segmentController.isHidden = false
            filterMovies = allmovies
            filteredTvShows = allTvShows
            movieTableView.reloadData()
        }
    }
    
}

// MARK : TableViewDelegate

extension MainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height/4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        if selected == 0 {
            self.navigationController?.pushViewController(MovieDetailsViewController(data : self.filterMovies[index], type : "movie"), animated: true)
        } else  if selected == 1 {
            self.navigationController?.pushViewController(MovieDetailsViewController(data: self.filteredTvShows[index], type: "show"), animated: true)
        }
    }
}

// MARK : TableViewDataSource

extension MainViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selected == 0 {
            return filterMovies.count
        } else if selected == 1 {
            return filteredTvShows.count
        } else {
            return filterMovies.count
        }}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoviesTableCell
        let movieExp = filterMovies[indexPath.row]
        tableCell.movieTitleLabel.text = movieExp.movieName
        let poster_path = movieExp.movieThumbnail
        let imageURl = URL(string: self.base_Image_URL + poster_path)
        tableCell.movieImageView.setImageWith(imageURl!)
        
        if selected == 1 {
            let tvShowExp = filteredTvShows[indexPath.row]
            tableCell.movieTitleLabel.text = tvShowExp.tvShowName
            let tvShowPosterPath = tvShowExp.tvShowThumbnail
            let tvShowImageURL = URL(string: self.base_Image_URL + tvShowPosterPath)
            tableCell.movieImageView.setImageWith(tvShowImageURL!)
            
        }
        return tableCell
    }
}
