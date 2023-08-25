//
//  TrackDetailView.swift
//  MusicApp
//
//  Created by Артем Гаршин on 18.08.2023.
//

import Foundation
import UIKit
import SDWebImage
import AVFoundation


class TrackDetailView: UIView{
    
    @IBOutlet weak var trackimageView: UIImageView!
    @IBOutlet weak var currentTime: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        trackimageView.backgroundColor = .blue
    }
    
    func set(viewModel: SearchViewModel.Cell){
        trackTitleLabel.text = viewModel.trackName
        authorTitleLabel.text = viewModel.artistName
        playTrack(previewUrl: viewModel.previewUrl)
        
        let string600 = viewModel.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600") // меняем разрешение 
        
        guard let url = URL(string: string600 ?? "") else {return}
        trackimageView.sd_setImage(with: url)
    }
    
    private func playTrack(previewUrl: String?){
        print("Gытаюсь включить трек по ссылке \(previewUrl ?? "Not")")
        
        guard let url = URL(string: previewUrl ?? "") else {return}
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    @IBAction func handleVolumeSlider(_ sender: Any) {
    }
    
    @IBAction func handleCurrentTimeSlider(_ sender: Any) {
    }
    
    @IBAction func dragDownButtonTapped(_ sender: Any) {
        
        self.removeFromSuperview()
    }
    
    
    @IBAction func previusTrack(_ sender: Any) {
    }
    
    @IBAction func nextTrack(_ sender: Any) {
    }
    
    
    @IBAction func playPauseAction(_ sender: Any) {
        if player.timeControlStatus == .paused{
            player.play()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }else{
            player.pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
}
