//
//  LandingViewControllerTests.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/6/25.
//


import XCTest
@testable import PatrickMoscovaResume

final class LandingViewControllerTests: XCTestCase {
    
    var viewController: LandingViewController?
    var spyCoordinator: SpyLandingCoordinator?

    override func setUp() {
        super.setUp()

        spyCoordinator = SpyLandingCoordinator(navigationController: UINavigationController())

        // Load from storyboard
        let storyboard = Constants.Storyboards.landing
        guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIDS.landingViewController) as? LandingViewController else {
            XCTFail("Could not load LandingViewController from storyboard")
            return
        }

        viewController = vc
        viewController?.coordinator = spyCoordinator
        viewController?.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
        spyCoordinator = nil
        super.tearDown()
    }

    func test_resumeButton_callsHandleWithShowResumeScreen() {
        guard let vc = viewController else {
            XCTFail("LandingViewController is nil")
            return
        }

        XCTAssertNotNil(vc.resumeButton, "resumeButton should be connected")
        vc.resumeButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(spyCoordinator?.receivedAction, .showResumeScreen)
    }

    func test_technicalSkillsButton_callsHandleWithShowTechSkillsScreen() {
        guard let vc = viewController else {
            XCTFail("LandingViewController is nil")
            return
        }

        XCTAssertNotNil(vc.technicalSkillsButton, "technicalSkillsButton should be connected")
        vc.technicalSkillsButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(spyCoordinator?.receivedAction, .showTechSkillsScreen)
    }
}
