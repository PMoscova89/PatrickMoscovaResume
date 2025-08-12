//
//  MediaPlayerControllerDelegateSpy.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/11/25.
//


import Foundation
@testable import PatrickMoscovaResume

final class MediaPlayerControllerDelegateSpy: MediaPlayerControllerDelegate {
    private(set) var loadedDuration: TimeInterval?
    private(set) var updatedTimes: [TimeInterval] = []
    private(set) var lastIsPlaying: Bool?
    private(set) var lastError: Error?

    func mediaPlayerDidLoadDuration(_ duration: TimeInterval) {
        loadedDuration = duration
    }
    func mediaDidUpdateProgress(_ currentTime: TimeInterval) {
        updatedTimes.append(currentTime)
    }
    func mediaPlaybackStatusDidChange(isPlaying: Bool) {
        lastIsPlaying = isPlaying
    }
    func mediaDidFail(_ error: Error) {
        lastError = error
    }
}