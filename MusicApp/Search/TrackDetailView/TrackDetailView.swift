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
    
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let scale: CGFloat = 0.8
        trackimageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        trackimageView.layer.cornerRadius = 5
        
        trackimageView.backgroundColor = .white
    }
    
    //MARK: - Setup
    func set(viewModel: SearchViewModel.Cell){
        trackTitleLabel.text = viewModel.trackName
        authorTitleLabel.text = viewModel.artistName
        playTrack(previewUrl: viewModel.previewUrl)
        monitorStartTime()
        observePlayerCurrentTime()
        
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
    
    //MARK: Time setup
    private func monitorStartTime(){
        
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        
        // нужно использовать weak self чтобы этот view удалялся из обьекта
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
            self?.enlargetrackimageView()
        }
    }
    
    private func observePlayerCurrentTime(){
        
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] (time) in
            self?.currentTimeLabel.text = time.toDisplayString() // сколько время уже играет
            
            let durationTime = self?.player.currentItem?.duration
            let currentDurationTimeText = ((durationTime ?? CMTimeMake(value: 1, timescale: 1)) - time).toDisplayString()
            
            self?.durationLabel.text = "-\(currentDurationTimeText)" // сколько время осталось
        }
    }
    
    
    //MARK: - Animations
    private func enlargetrackimageView(){
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.trackimageView.transform = .identity
        }
    }
    
    private func reduceTrackImageView(){
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut) {
            let scale: CGFloat = 0.8
            self.trackimageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    
    //MARK: - @IBACTIONS
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
            enlargetrackimageView()
        }else{
            player.pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            reduceTrackImageView()
        }
    }
    
}
