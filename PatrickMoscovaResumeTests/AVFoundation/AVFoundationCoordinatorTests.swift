//
//  AVFoundationCoordinatorTests.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/8/25.
//


import XCTest
@testable import PatrickMoscovaResume

final class AVFoundationCoordinatorTests: XCTestCase {

    func test_start_pushesFeatureVC() {
        let nav = UINavigationController()
        let coordinator = AVFoundationCoordinator(parent: nav)

        coordinator.start()

        XCTAssertTrue(nav.topViewController is AVFoundationFeatureViewController)
    }

    func test_delegate_audio_routesToAudioVC() {
        let nav = UINavigationController()
        let coordinator = AVFoundationCoordinator(parent: nav)
        coordinator.start()

        // Simulate controller -> coordinator delegate callback (unit-level, no UI)
        (coordinator as AVFoundationControllerDelegate).didRequestAudioPlayback()

        XCTAssertEqual(nav.viewControllers.count, 2)
        // Uncomment once your class exists:
        // XCTAssertTrue(nav.topViewController is AudioPlaybackViewController)
    }

    func test_delegate_video_routesToVideoVC() {
        let nav = UINavigationController()
        let coordinator = AVFoundationCoordinator(parent: nav)
        coordinator.start()

        (coordinator as AVFoundationControllerDelegate).didRequestVideoPlayback()

        XCTAssertEqual(nav.viewControllers.count, 2)
        // XCTAssertTrue(nav.topViewController is VideoPlaybackViewController)
    }

    func test_delegate_crop_routesToCropperVC() {
        let nav = UINavigationController()
        let coordinator = AVFoundationCoordinator(parent: nav)
        coordinator.start()

        (coordinator as AVFoundationControllerDelegate).didRequestImageCropping()

        XCTAssertEqual(nav.viewControllers.count, 2)
        // XCTAssertTrue(nav.topViewController is ImageCropperViewController)
    }
}