//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Olga Saliy on 5/23/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import UIKit

enum TypeCell: Int {
    case loading = 0, movieDetailed, overview
    
    static let count = 1
}

typealias MovieType = (movie: Movie, poster: UIImage)

class MovieDetailViewController: UITableViewController {

    var movie: MovieType = (Movie(), #imageLiteral(resourceName: "not-available"))
    var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        downloadAdditionalInfo()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? 1 : TypeCell.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = isLoading ? indexPath.row : indexPath.row + 1
        if let typeCell = TypeCell(rawValue: index){
            switch typeCell {
            case .movieDetailed:
                let cell = tableView.dequeueReusableCell(withIdentifier: "movieDetailCell", for: indexPath) as! MovieDetailCell
                cell.configure(with: movie.poster, description: movie.movie.genres ?? "Unknown genre", title: movie.movie.title, liked: false)
                cell.delegate = self
                return cell
            case .loading:
                let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
                return cell
            case .overview:
                fallthrough
            default:
                break
            }
        }
        return UITableViewCell()
    }
    
    //MARK: - Download data
    
    private func downloadAdditionalInfo() {
        MovieManager.shared.getMovieDetails(for: movie.movie) { updatedMovie, error in
            if let errorUnwrapped = error {
                print(errorUnwrapped.localizedDescription)
            }
            
            sleep(1)
            
            self.movie.movie = updatedMovie
            self.isLoading = false
            self.tableView.reloadData()
        }
    }
}

extension MovieDetailViewController: MovieDetailCellDelegate {
    
    func didTapLike(_ sender: MovieDetailCell) {
        //add to core data
        movie.movie.isLiked = true
    }
    
}
