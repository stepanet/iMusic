//
//  SearchViewController.swift
//  iMusic
//
//  Created by Пятин Дмитрий on 19.07.2020.
//  Copyright © 2020 Пятин Дмитрий. All rights reserved.
//

import UIKit


struct TrackModel {
    var trackName: String
    var artistName: String
    var image: UIImage
}

class SearchViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let cellid = "cellid"
    let tracks = [
        TrackModel(trackName: "Are You Even Real?", artistName: "James Blake", image: #imageLiteral(resourceName: "Assume Form")),
        TrackModel(trackName: "Retrograde", artistName: "James Blake", image: #imageLiteral(resourceName: "You're Too Precious - Single")),
        TrackModel(trackName: "You're Too Precious", artistName: "James Blake", image: #imageLiteral(resourceName: "James Blake")),
        TrackModel(trackName: "Mile High (feat. Travis Scott & Metro Boomin)", artistName: "James Blake", image: #imageLiteral(resourceName: "James Blake")),
        TrackModel(trackName: "The Wilhelm Scream", artistName: "James Blake", image: #imageLiteral(resourceName: "Overgrown (Deluxe Edition)")),
        TrackModel(trackName: "Barefoot in the Park (feat. ROSALÍA)", artistName: "James Blake", image: #imageLiteral(resourceName: "You're Too Precious - Single"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        view.backgroundColor = .white
        setupSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        let track = tracks[indexPath.row]
        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = track.image
        return cell
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 5 {
         print(searchText)
        }
    }
}
