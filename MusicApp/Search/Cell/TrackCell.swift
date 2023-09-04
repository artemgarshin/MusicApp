//
//  trackCell.swift
//  MusicApp
//


import Foundation
import UIKit
import SDWebImage


protocol TrackCellViewModel {
    var iconUrlString: String? {get}
    var trackName: String {get}
    var artistName: String {get}
    var collectionName: String {get}
}

class TrackCell: UITableViewCell{
    
    static let reuseId = "TrackCell"
    
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var tracknameLabel: UILabel!
    @IBOutlet weak var trackimageView: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var addTrackOutlet: UIButton!
    //для экономии памяти потому что ячейки исчезают елси ячейки не видын они отправляютс в кеш
    override func prepareForReuse() {

        super.prepareForReuse()
        
        trackimageView.image = nil
    }
    
    var cell: SearchViewModel.Cell?
    
    func set(viewModel: SearchViewModel.Cell){
        
        self.cell = viewModel
        let savedTracks = UserDefaults.standard.savedTracks()
        let hasFavourite = savedTracks.firstIndex(where: {
            $0.trackName == self.cell?.trackName && $0.artistName == self.cell?.artistName
        }) != nil
        if hasFavourite{
            addTrackOutlet.isHidden = true
        } else{
            addTrackOutlet.isHidden = false
        }
        
        tracknameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName

        guard let url = URL(string: viewModel.iconUrlString ?? "") else{return}
        
        trackimageView.sd_setImage(with: url, completed: nil)
    }
    
    
    @IBAction func addTrackAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        guard let cell = cell else {return}
        addTrackOutlet.isHidden = true
        var listOfTracks = defaults.savedTracks()
        
        listOfTracks.append(cell)
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: listOfTracks, requiringSecureCoding: false){
            print("успех")
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    

}
