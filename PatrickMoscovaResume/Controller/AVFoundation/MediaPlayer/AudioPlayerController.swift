//
//  AudioPlayerController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/11/25.
//

import Foundation
import AVFoundation
import UIKit

final class AudioPlayerController: NSObject, MediaPlayerControllerProtocol {
    
    weak var delegate: MediaPlayerControllerDelegate?
    private var player: AVAudioPlayer?
    private var progessTimer: Timer?
    
    var isPlaying: Bool {player?.isPlaying == true}
    var duration: TimeInterval? {player?.duration}
    var currentTime: TimeInterval {player?.currentTime ?? 0}
    
    deinit{
        //StopTimer()
    }
    func loadMedia(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let p = try AVAudioPlayer(data: data)
            p.prepareToPlay()
            p.enableRate = true
            p.isMeteringEnabled = true
            player = p
            delegate?.mediaPlayerDidLoadDuration(p.duration)
            delegate?.mediaDidUpdateProgress(0)
        }catch {
            delegate?.mediaDidFail(error)
        }
    }
    
    func handle(_ action: MediaUserAction) {
        switch action {
            case .play:
                play()
            case .pause:
                pause()
            case .scrubBegan:
                stopTimer()
            case .scrubEnded:
                if isPlaying {
                    startTimer()
                }
            case .seek(toSeconds: let seconds):
                seek(to: seconds)
            case .importFile:
                break
                
        }
    }
    
    private func play() {
        guard let player else {return}
        if !player.isPlaying {
            player.play()
            startTimer()
        }
        delegate?.mediaPlaybackStatusDidChange(isPlaying: true)
    }
    
    private func pause() {
        guard let player else {return}
        if player.isPlaying {
            player.pause()
            stopTimer()
        }
        delegate?.mediaPlaybackStatusDidChange(isPlaying: false)
    }
    
    private func seek(to seconds: TimeInterval) {
        guard let player else {return}
        player.currentTime = max(0, min(seconds, player.duration))
        delegate?.mediaDidUpdateProgress(player.currentTime)
    }
    
    private func startTimer() {
        stopTimer()
        progessTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            guard let self = self else {return}
            guard let thePlayer = self.player else {return}
            self.delegate?.mediaDidUpdateProgress(thePlayer.currentTime)
            if !thePlayer.isPlaying {
                self.stopTimer()
            }
            if let theTimer = self.progessTimer {
                RunLoop.main.add(theTimer, forMode: .common)
            }
            
        }
    }
    
    private func stopTimer() {
        progessTimer?.invalidate()
        progessTimer = nil
    }
}
