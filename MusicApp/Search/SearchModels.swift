//
//  SearchModels.swift
//  MusicApp
//
//  Created by Артем Гаршин on 13.08.2023.

//

import UIKit

enum Search {
    
    enum Model {
        struct Request {
            enum RequestType {
                case some
                case getTracks(searchTerm: String)
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case presentTracks(SearchResponse: SearchResponse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayTracks(searchViewModel: SearchViewModel)
            }
        }
    }
    
    
}


//MARK: -структура для придавани янормальных названияй и подготовка данных 
struct SearchViewModel{
    struct Cell{
        var iconUrlString: String?
        var trackName: String
        var collectionName: String?
        var artistName: String
    }
    
    let cells: [Cell]
}
