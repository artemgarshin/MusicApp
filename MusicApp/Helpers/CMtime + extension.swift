//
//  CMtime + extension.swift
//  MusicApp
//


import Foundation
import AVFoundation

//MARK: -time to string
extension CMTime{
    
    func toDisplayString() -> String{
        guard !CMTimeGetSeconds(self).isNaN else {return ""}
        let totalSecond = Int(CMTimeGetSeconds(self))
        let seconds = totalSecond % 60
        let mitunes = totalSecond / 60
        let timeFormatString = String(format: "%02d:%02d", mitunes,seconds)
        
        return timeFormatString
    }
}
