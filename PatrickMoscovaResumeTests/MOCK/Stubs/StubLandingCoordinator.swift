//
//  StubLandingCoordinator.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/6/25.
//


@testable import PatrickMoscovaResume

final class StubLandingCoordinator: LandingCoordinator {
    var didCallShowResume = false
    var didCallShowSkills = false

    override func showResume() {
        didCallShowResume = true
    }

    override func showTechSkillsSelection() {
        didCallShowSkills = true
    }
}
