//
//  SearchViewController.swift
//  iMusic
//
//  Created by Пятин Дмитрий on 19.07.2020.
//  Copyright © 2020 Пятин Дмитрий. All rights reserved.
//

import UIKit
import Alamofire


class SearchViewController: UITableViewController {
    
    var timer: Timer?
    var networkService = NetworkService()
    
    let searchController = UISearchController(searchResultsController: nil)
    let cellid = "cellid"
    
    var tracks = [Track]()
    
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
        //cell.imageView?.image = track.artworkUrl100
        return cell
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
        
        let searchReplaceText = searchText.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
            self.networkService.fetchTracks(searchText: searchReplaceText) { [weak self] (searchResults) in
                self?.tracks = searchResults!.results 
                self?.tableView.reloadData()
            }
            

        })
    }
}
