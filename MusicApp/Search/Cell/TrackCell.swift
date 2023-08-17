//
//  trackCell.swift
//  MusicApp
//
//  Created by Артем Гаршин on 17.08.2023.
//

import Foundation
import UIKit


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
    
    
    
    func set(viewModel: TrackCellViewModel){
        tracknameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName

        
    }
}
