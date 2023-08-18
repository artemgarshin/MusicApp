//
//  NetworkSrevice.swift
//  MusicApp
//
//  
//

import Foundation
import UIKit
import Alamofire


class NetworkSrevice{
    
    func fetchTracks(searchText:String, competion: @escaping(SearchResponse?) -> Void){
        let url = "https://itunes.apple.com/search"
        let parameters = ["term":"\(searchText)",
                         "limit":"10",
                          "media":"music"]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error received requestiong data: \(error.localizedDescription)")
                competion(nil)
                return
            }
            
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode(SearchResponse.self, from: data)
                print("objects: ", objects)
                competion(objects)

                
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                competion(nil)
            }
//            let someString = String(data: data, encoding: .utf8)
//            print(someString ?? "")
        }
    }
    
    
}
