//
//  MediaPlayerControllerDelegate.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/11/25.
//

import Foundation
import CoreGraphics

protocol MediaPlayerControllerDelegate: AnyObject {
    func mediaPlayerDidLoadDuration(_ duration: TimeInterval)
    func mediaDidUpdateProgress(_ currentTime: TimeInterval)
    func mediaPlaybackStatusDidChange( isPlaying: Bool)
    func mediaDidFail(_ error: Error)
}

