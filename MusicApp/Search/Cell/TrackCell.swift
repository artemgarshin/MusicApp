//
//  trackCell.swift
//  MusicApp
//
//  Created by Артем Гаршин on 17.08.2023.
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
    
    //для экономии памяти потому что ячейки исчезают елси ячейки не видын они отправляютс в кеш
    override func prepareForReuse() {

        super.prepareForReuse()
        
        trackimageView.image = nil
    }
    
    func set(viewModel: TrackCellViewModel){
        tracknameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName

        guard let url = URL(string: viewModel.iconUrlString ?? "") else{return}
        
        trackimageView.sd_setImage(with: url, completed: nil)
    }
}
