//
//  VideoPlayerController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/12/25.
//

import Foundation
import AVFoundation
import UIKit
import Combine


final class VideoPlayerController: NSObject, MediaPlayerControllerProtocol {
    weak var delegate: MediaPlayerControllerDelegate?
    
    
    private var player: AVPlayer?
    private var timeObserver: Any?
    private weak var renderView: UIView?
    private weak var playerLayer: AVPlayerLayer?
    
    private var durationSent : Bool = false
    private var pendingSeekTarget: Double?
    
    var isPlaying : Bool { player?.timeControlStatus == .playing}
    var duration: TimeInterval? {
        guard let seconds = player?.currentItem?.asset.duration.seconds else {return nil}
        return seconds.isFinite ? seconds : nil
    }
    var currentTime: TimeInterval {player?.currentTime().seconds ?? 0}
    
    func handle(_ action: MediaUserAction) {
        switch action {
            case .play:
                player?.play()
                delegate?.mediaPlaybackStatusDidChange(isPlaying: true)
            case .pause:
                player?.pause()
                delegate?.mediaPlaybackStatusDidChange(isPlaying: false)
            case .seek(toSeconds: let seconds):
                guard let thePlayer = player else {return}
                let clamped = max(0, seconds)
                pendingSeekTarget = clamped
                let time = CMTime(seconds: Double(clamped), preferredTimescale: 600)
                thePlayer.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero) { [weak self] _ in
                    guard let self = self else {return}
                    self.delegate?.mediaDidUpdateProgress(self.currentTime)
                    if abs(self.currentTime - clamped) < 0.25{
                        self.pendingSeekTarget = nil
                    }
                }
            case .scrubBegan:
                break
            case .scrubEnded:
                break
            case .importFile:
                break
                
        }
    }
    
    func loadMedia(url: URL) {
        Task { @MainActor in
            configureAudioSession()
            let asset = AVURLAsset(url: url)
            do {
                try await asset.prepareForPlayback()
            }catch {
                delegate?.mediaDidFail(error)
                print("media did fail")
                return
            }
            let item = AVPlayerItem(asset: asset)
            item.addObserver(self, forKeyPath: "status", options: [.initial, .new], context: nil)
            let thePlayer = AVPlayer(playerItem: item)
            player = thePlayer
            
            if let view = renderView {
                let layer = AVPlayerLayer(player: thePlayer)
                layer.videoGravity = .resizeAspect
                layer.frame = view.bounds
                layer.needsDisplayOnBoundsChange = true
                view.layer.addSublayer(layer)
                playerLayer = layer
            }
            startObserving()
            
            if let seconds = asset.safeDurationSeconds {
                delegate?.mediaPlayerDidLoadDuration(seconds)
            }
            
        }
        
    }
    
    deinit {
        stopObserving()
        player?.pause()
        if let theItem = player?.currentItem {
            theItem.removeObserver(self, forKeyPath: "status", context: nil)
        }
    }
    
    func attachRenderView(_ view: UIView) {
        renderView = view
        playerLayer?.removeFromSuperlayer()
        
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspect
        layer.frame = view.bounds
        layer.needsDisplayOnBoundsChange = true
        view.layer.addSublayer(layer)
        playerLayer = layer
    }
    
}

//MARK: private extension

private extension VideoPlayerController {
    
    @MainActor
    func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .moviePlayback, options: [])
            try session.setActive(true, options: [])
        }catch {
            print("failure in setting audio session")
        }
    }
    
    func doThisOnMain(_ theWork: @escaping () -> Void) {
        if Thread.isMainThread {
            theWork()
        }else {
            DispatchQueue.main.async(execute: theWork)
        }
    }
    
    func startObserving() {
        stopObserving()
        guard let thePlayer = player else {return}
        let interval = CMTime(seconds: 0.1, preferredTimescale: 600)
        timeObserver = thePlayer.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { [weak self] _ in
            guard let self = self else {return}
            if self.durationSent == false, let theDuration = self.duration {
                self.durationSent = true
                self.delegate?.mediaPlayerDidLoadDuration(theDuration)
            }
            
            if let theTarget = self.pendingSeekTarget {
                if abs(self.currentTime - theTarget) < 0.25 {
                    self.pendingSeekTarget = nil
                }else {
                    return
                }
            }
            self.delegate?.mediaDidUpdateProgress(self.currentTime)
            
        })
    }
    
    func stopObserving() {
        if let obs = timeObserver, let thePlayer = player {
            thePlayer.removeTimeObserver(obs)
        }
        timeObserver = nil
    }
    
    internal override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "status", let item = object as? AVPlayerItem else { return }
        switch item.status {
            case .readyToPlay:
                // If the periodic observer hasn’t reported duration yet, do it once here.
                if durationSent == false, let d = duration {
                    durationSent = true
                    delegate?.mediaPlayerDidLoadDuration(d)
                }
            case .failed:
                if let err = item.error { delegate?.mediaDidFail(err) }
            case .unknown:
                break
            @unknown default:
                break
        }
    }
}
