//
//  AVAudioSession+Playback.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/13/25.
//

import AVFoundation

enum AudioSessionConfigurator {
    static func configureForMoviePlayback() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .moviePlayback, options: [])
            try session.setActive(true, options: [])
        } catch {
            // Non-fatal: video can show without sound. Log if needed.
        }
    }
}
