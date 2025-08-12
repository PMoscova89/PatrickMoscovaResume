//
//  MockMediaController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/11/25.
//


import UIKit
@testable import PatrickMoscovaResume

final class MockMediaController: MediaPlayerControllerProtocol {
    weak var delegate: MediaPlayerControllerDelegate?

    var isPlaying: Bool = false
    var duration: TimeInterval? = 90
    var currentTime: TimeInterval = 0

    private(set) var lastAction: MediaUserAction?
    private(set) var attachedView: UIView?

    func loadMedia(url: URL) {
        // simulate a successful load
        delegate?.mediaPlayerDidLoadDuration(duration ?? 0)
        delegate?.mediaDidUpdateProgress(0)
    }

    func handle(_ action: MediaUserAction) {
        lastAction = action
        switch action {
        case .play:
            isPlaying = true
            delegate?.mediaPlaybackStatusDidChange(isPlaying: true)
        case .pause:
            isPlaying = false
            delegate?.mediaPlaybackStatusDidChange(isPlaying: false)
        case .seek(let t):
            currentTime = max(0, min(t, duration ?? t))
            delegate?.mediaDidUpdateProgress(currentTime)
        case .scrubBegan, .scrubEnded, .importFile:
            break
        }
    }

    func attachRenderView(_ view: UIView) {
        attachedView = view
    }
}
