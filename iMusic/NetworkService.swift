//
//  NetworkService.swift
//  iMusic
//
//  Created by Пятин Дмитрий on 21.07.2020.
//  Copyright © 2020 Пятин Дмитрий. All rights reserved.
//

import UIKit
import Alamofire


class NetworkService {
    
    func fetchTracks(searchText: String, completion: @escaping (SearchResponce?) -> Void) {
        let url = "https://itunes.apple.com/search"
        let parametrs = ["term":"\(searchText)", "limit":"10", "media":"music"]

            AF.request(url, method: .get, parameters: parametrs, encoder: URLEncodedFormParameterEncoder.default, headers: nil).response { response in

                if let error = response.error {
                    print("Network error: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let data = response.data else { return }
                let decoder = JSONDecoder()
                do {
                    
                    let objects = try decoder.decode(SearchResponce.self, from: data)
                    //print("object:", objects.results)
                    completion(objects)

                } catch let jsonError {
                    print("failed decode json", jsonError)
                    completion(nil)
                }
            }
    }
    
}
