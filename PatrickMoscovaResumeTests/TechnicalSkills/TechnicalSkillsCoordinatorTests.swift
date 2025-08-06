//
//  TechnicalSkillsCoordinatorTests.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/6/25.
//


import XCTest
@testable import PatrickMoscovaResume

final class TechnicalSkillsCoordinatorTests: XCTestCase {

    var spyNavigationController: SpyNavigationController!
    var coordinator: TechnicalSkillsCoordinator!

    override func setUp() {
        super.setUp()
        spyNavigationController = SpyNavigationController()
        coordinator = TechnicalSkillsCoordinator(navigationController: spyNavigationController)
    }

    override func tearDown() {
        coordinator = nil
        spyNavigationController = nil
        super.tearDown()
    }

    func test_start_pushesTechnicalSkillsViewController() {
        coordinator.start()

        XCTAssertTrue(spyNavigationController.didPushViewController)
        XCTAssertTrue(spyNavigationController.pushedViewController is TechnicalSkillsViewController)
    }

    func test_selectingSkill_pushesSkillDetailStubViewController() {
        coordinator.start()

        guard let skillsVC = spyNavigationController.pushedViewController as? TechnicalSkillsViewController else {
            XCTFail("Expected TechnicalSkillsViewController to be pushed")
            return
        }

        let expectedSkill = TechnicalSkill.allCases.first!
        skillsVC.onSkillSelected?(expectedSkill)

        guard let pushedVC = spyNavigationController.viewControllers.last as? SkillDetailStubViewController else {
            XCTFail("Expected SkillDetailStubViewController to be pushed")
            return
        }

        XCTAssertEqual(pushedVC.title, expectedSkill.rawValue)
    }

    func test_stop_popsViewController() {
        _ = coordinator.navigationController.view // Trigger internal VC stack
        coordinator.stop()

        XCTAssertTrue(spyNavigationController.didPopViewController)
    }
}
