//
//  ViewController.swift
//  Movies
//
//  Created by Olha Salii on 5/17/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [Movie : UIImage]()
    var moviesArray = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        MovieManager.shared.getMoviesAndPosters(by: "best") { result, error in
            if let errorUnwrapped = error {
                print(errorUnwrapped.localizedDescription)
            } else {
                if result != nil {
                    self.movies = result!
                    self.moviesArray = Array(self.movies.keys)
                    self.collectionView.reloadSections(IndexSet(integer: 0))
                    self.activityIndicator.isHidden = true
                    self.collectionView.isHidden = false
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            if let detailViewController = segue.destination as? MovieDetailViewController,
               let indexPath = self.collectionView.indexPathsForSelectedItems?.first {
                let movie = moviesArray[indexPath.row]
                detailViewController.movie = (movie: movie, poster: movies[movie] ?? #imageLiteral(resourceName: "not-available"))
            }
        }
    }
    
    //MARK: - CollectionView Delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieListCell", for: indexPath) as! MovieListCell
        let movie = moviesArray[indexPath.row]
        cell.configureCell(image: movies[movie] ?? #imageLiteral(resourceName: "not-available"), title: movie.title)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width / 16 * 7, height: self.collectionView.frame.height / 7 * 4)
    }
    
    //MARK: - Downloading data
    
    func searchMovies(by query: String) {
        collectionView.isHidden = true
        activityIndicator.isHidden = false
        
        MovieManager.shared.getMoviesAndPosters(by: query) { result, error in
            if let errorUnwrapped = error {
                print(errorUnwrapped.localizedDescription)
            } else {
                if result != nil {
                    self.movies = result!
                    self.moviesArray = Array(self.movies.keys)
                    self.collectionView.reloadSections(IndexSet(integer: 0))
                    self.activityIndicator.isHidden = true
                    self.collectionView.isHidden = false
                }
            }
        }
    }
}

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count > 2 {
            searchMovies(by: text)
            searchBar.resignFirstResponder()
            searchBar.setShowsCancelButton(false, animated: true)
        }
    }

}

