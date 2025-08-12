//
//  AVFoundationCoordinatorAudioRouteTests.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/11/25.
//


import XCTest
@testable import PatrickMoscovaResume

final class AVFoundationCoordinatorAudioRouteTests: XCTestCase {

    // A tiny host VC so we can call `display(_:from:)`
    private final class HostVC: UIViewController {}

    // Spy to intercept presentation/push via our shared `display` logic:
    private final class InterceptNav: UINavigationController {
        var lastPushed: UIViewController?
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            lastPushed = viewController
            super.pushViewController(viewController, animated: false)
        }
    }

    func test_showAudio_routesToMediaPlayerVC() {
        let host = HostVC()
        let nav = InterceptNav(rootViewController: host)

        // Build the AVFoundationFeature screen so `viewController` is set
        let featureController = AVFoundationController()
        let coordinator = AVFoundationCoordinator(parent: nav, controller: featureController)
        coordinator.start()

        // Simulate tapping "Play Audio"
        featureController.performUserAction(.audioTapped)

        // The coordinator should push a MediaPlayerViewController
        XCTAssertTrue(nav.lastPushed is MediaPlayerViewController,
                      "Expected MediaPlayerViewController to be displayed for audio route")
    }
}