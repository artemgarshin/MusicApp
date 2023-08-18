//
//  SearchInteractor.swift
//  MusicApp
//


import UIKit

protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {
    
    var networkService = NetworkSrevice()
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        switch request{
        case .getTracks(let searchTerm):
            print("Interactor .getTracks")
            presenter?.presentData(response: Search.Model.Response.ResponseType.presentFooterView)
            networkService.fetchTracks(searchText: searchTerm) { [weak self](searchResponse) in
                self?.presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks(SearchResponse: searchResponse))
            }
        }
        
    }
}
