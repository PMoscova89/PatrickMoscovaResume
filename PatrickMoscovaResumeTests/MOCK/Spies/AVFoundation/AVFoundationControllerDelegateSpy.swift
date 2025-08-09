//
//  AVFoundationControllerDelegateSpy.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/8/25.
//


import Foundation
@testable import PatrickMoscovaResume

final class AVFoundationControllerDelegateSpy: AVFoundationControllerDelegate {
    private(set) var didRequestAudioCount = 0
    private(set) var didRequestVideoCount = 0
    private(set) var didRequestCropCount  = 0

    var didRequestAudioPlaybackCalled: Bool { didRequestAudioCount > 0 }
    var didRequestVideoPlaybackCalled: Bool { didRequestVideoCount > 0 }
    var didRequestImageCroppingCalled: Bool { didRequestCropCount  > 0 }

    func didRequestAudioPlayback()  { didRequestAudioCount += 1 }
    func didRequestVideoPlayback()  { didRequestVideoCount += 1 }
    func didRequestImageCropping()  { didRequestCropCount  += 1 }

    func reset() {
        didRequestAudioCount = 0
        didRequestVideoCount = 0
        didRequestCropCount  = 0
    }
}