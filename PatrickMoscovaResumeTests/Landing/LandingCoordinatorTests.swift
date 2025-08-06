//
//  LandingCoordinatorTests.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/6/25.
//
import XCTest
@testable import PatrickMoscovaResume

final class LandingCoordinatorTests: XCTestCase {
    
    var landingVC: LandingViewController!
    var spyCoordinator: SpyLandingCoordinator!
    
    override func setUp() {
        super.setUp()
        
        spyCoordinator = SpyLandingCoordinator(navigationController: UINavigationController())
        
        // Load from storyboard to ensure IBOutlet connections
        let storyboard = Constants.Storyboards.landing
        guard let viewController = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIDS.landingViewController) as? LandingViewController else {
            XCTFail("Failed to instantiate LandingViewController from storyboard")
            return
        }
        
        landingVC = viewController
        landingVC.coordinator = spyCoordinator
        landingVC.loadViewIfNeeded()
    }
    
    override func tearDown() {
        landingVC = nil
        spyCoordinator = nil
        super.tearDown()
    }
    
    func test_resumeButtonTap_triggersHandleWithShowResumeScreen() {
        XCTAssertNotNil(landingVC.resumeButton, "resumeButton should be connected")
        landingVC.resumeButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(spyCoordinator.receivedAction, .showResumeScreen)
    }
    
    func test_technicalSkillsButtonTap_triggersHandleWithShowTechSkillsScreen() {
        XCTAssertNotNil(landingVC.technicalSkillsButton, "technicalSkillsButton should be connected")
        landingVC.technicalSkillsButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(spyCoordinator.receivedAction, .showTechSkillsScreen)
    }
}
