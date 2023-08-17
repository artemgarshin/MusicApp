//
//  SearchPresenter.swift
//  MusicApp
//
//  Created by Артем Гаршин on 13.08.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    func presentData(response: Search.Model.Response.ResponseType) {
        switch response{
            
        case .some:
            print("presentor .som")
        case .presentTracks(let searchResults):
            let cells = searchResults?.results.map({ (track) in
                cellViewModel(from: track)
            }) ?? []
            
            
            let searchViewModel = SearchViewModel(cells: cells)
            print("presentor .presentTracks")
            viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayTracks(searchViewModel: searchViewModel))
        }
    }
    
    private func cellViewModel(from track: Track) -> SearchViewModel.Cell{
        
        return SearchViewModel.Cell.init(iconUrlString: track.artworkUrl100,
                                         trackName: track.trackName,
                                         collectionName: track.collectionName ?? "",
                                         artistName: track.artistName,
                                         previewUrl: track.previewUrl)
    }
    
}
