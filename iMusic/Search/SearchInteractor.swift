//
//  SearchInteractor.swift
//  iMusic
//
//  Created by Пятин Дмитрий on 22.07.2020.
//  Copyright (c) 2020 Пятин Дмитрий. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
  func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {

  var networkService = NetworkService()
    var presenter: SearchPresentationLogic?
  var service: SearchService?
  
  func makeRequest(request: Search.Model.Request.RequestType) {
    if service == nil {
      service = SearchService()
    }
    
    switch request {
    case .getTracks(let searchTerm):
        print("interactor .getTracks")
        presenter?.presentData(response: .presentFooterView)
        networkService.fetchTracks(searchText: searchTerm) { [weak self](searchResponce) in
            self?.presenter?.presentData(response: .presentTracks(searchResponce: searchResponce))
        }
        
    }
    
    
  }
  
}
