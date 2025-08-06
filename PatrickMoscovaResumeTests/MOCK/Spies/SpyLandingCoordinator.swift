//
//  SpyLandingCoordinator.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/6/25.
//


@testable import PatrickMoscovaResume

final class SpyLandingCoordinator: LandingCoordinator {
    private(set) var receivedAction: LandingViewController.LandingUserAction?

    override func handle(action: UserAction) {
        if let landingAction = action as? LandingViewController.LandingUserAction {
            receivedAction = landingAction
        }
    }
}
