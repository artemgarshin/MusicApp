//
//  TrackDetailView.swift
//  MusicApp
//


import Foundation
import UIKit
import SDWebImage
import AVFoundation

protocol TrackMovingDelegate: class{
    func moveBackForPreviousTrack() -> SearchViewModel.Cell?
    func moveForwardForNextTrack() -> SearchViewModel.Cell?
}

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
    
    
    weak var delegate: TrackMovingDelegate?
    
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
        playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
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
            self?.updateCurrentTimeSlider()
        }
    }
    
    
    private func updateCurrentTimeSlider(){
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        
        let percentage = currentTimeSeconds / durationSeconds
        self.currentTime.value = Float(percentage)
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
        player.volume = volumeSlider.value
        
    }
    
    @IBAction func handleCurrentTimeSlider(_ sender: Any) {
        let percentage = currentTime.value
        guard let duration = player.currentItem?.duration else {return}
        let durationInSeconds = CMTimeGetSeconds(duration)
        
        let seekTimeInSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        player.seek(to: seekTime)
    }
    
    @IBAction func dragDownButtonTapped(_ sender: Any) {
        
        self.removeFromSuperview()
    }
    
    
    @IBAction func previusTrack(_ sender: Any) {
        let cellViewModel = delegate?.moveBackForPreviousTrack()
        guard let cellInfo = cellViewModel else {return}
        self.set(viewModel: cellInfo)
    }
    
    @IBAction func nextTrack(_ sender: Any) {
        let cellViewModel = delegate?.moveForwardForNextTrack()
        guard let cellInfo = cellViewModel else {return}
        self.set(viewModel: cellInfo)
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
