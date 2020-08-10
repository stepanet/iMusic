//
//  SearchViewController.swift
//  iMusic
//
//  Created by Пятин Дмитрий on 22.07.2020.
//  Copyright (c) 2020 Пятин Дмитрий. All rights reserved.
//  Отображение данных на экране

import UIKit

protocol SearchDisplayLogic: class {
    func displayData(viewModel: Search.Model.ViewModel.ViewModelData)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic)?
    var timer: Timer?
    
    private lazy var footerView = FooterView()
    
    @IBOutlet weak var table: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    private var searchViewModel = SearchViewModel.init(cells: [])
    
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = SearchInteractor()
        let presenter             = SearchPresenter()
        let router                = SearchRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupSearchBar()
        setupTableView()
    }
    
    
    private func setupTableView() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        
        let nib = UINib(nibName: "TrackCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: TrackCell.reuseId)
        table.tableFooterView = footerView
    }
    
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func displayData(viewModel: Search.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
        case .displayTracks(let searchViewModel):
            print("viewModel . displayTracks")
            self.searchViewModel = searchViewModel
            table.reloadData()
            footerView.hideLoader()
            
        case .displayFooterView:
            footerView.showLoading()
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Введите в поиск название..."
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return searchViewModel.cells.count > 0 ? 0 : 250 
    }
    
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: TrackCell.reuseId, for: indexPath) as! TrackCell
        
        let cellViewModel = searchViewModel.cells[indexPath.row]
        cell.trackImageView.backgroundColor = .red
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = searchViewModel.cells[indexPath.row]
        print(cellViewModel.artistName)
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
           // UIApplication.shared.keyWindow
        let trackDetailView = Bundle.main.loadNibNamed("TrackDetailView", owner: self, options: nil)?.first as! TrackDetailView
        window?.addSubview(trackDetailView)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
}


//MARK:
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
        
        let searchReplaceText = searchText.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
            self.interactor?.makeRequest(request: .getTracks(searchTerm: searchReplaceText))
        
        })
    }
}
