//
//  AVFoundationControllerTests.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/8/25.
//


import XCTest
@testable import PatrickMoscovaResume

final class AVFoundationControllerTests: XCTestCase {

    func test_audioAction_notifiesDelegate() {
        let controller = AVFoundationController()
        let delegateSpy = AVFoundationControllerDelegateSpy()
        controller.delegate = delegateSpy

        controller.performUserAction(.audioTapped)

        XCTAssertTrue(delegateSpy.didRequestAudioPlaybackCalled)
        XCTAssertFalse(delegateSpy.didRequestVideoPlaybackCalled)
        XCTAssertFalse(delegateSpy.didRequestImageCroppingCalled)
    }

    func test_videoAction_notifiesDelegate() {
        let controller = AVFoundationController()
        let delegateSpy = AVFoundationControllerDelegateSpy()
        controller.delegate = delegateSpy

        controller.performUserAction(.videoTapped)

        XCTAssertTrue(delegateSpy.didRequestVideoPlaybackCalled)
    }

    func test_imageCropperAction_notifiesDelegate() {
        let controller = AVFoundationController()
        let delegateSpy = AVFoundationControllerDelegateSpy()
        controller.delegate = delegateSpy

        controller.performUserAction(.imageCropperTapped)

        XCTAssertTrue(delegateSpy.didRequestImageCroppingCalled)
    }
}