//
//  SearchResponse.swift
//  iMusic
//
//  Created by Пятин Дмитрий on 21.07.2020.
//  Copyright © 2020 Пятин Дмитрий. All rights reserved.
//

import Foundation


struct SearchResponce: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl100: String?
}
