//
//  SearchResponse.swift
//  MusicApp
//
//  Created by Артем Гаршин on 19.07.2023.
//
//Модель запроса из эпл музыки 
import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl100: String?
    var previewUrl: String?
}



