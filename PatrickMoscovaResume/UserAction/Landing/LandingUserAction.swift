//
//  LandingUserAction.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/29/25.
//

extension LandingCoordinator.LandingUserAction {
    init?(_ vcAction: LandingViewController.LandingUserAction) {
        switch vcAction {
            case .showResumeScreen:
                self = .showResumeScreen
            case .showProjectScreen:
                self = .showProjectScreen
            case .showTechSkillsScreen:
                self = .showTechSkillsScreen
        }
    }
}

extension LandingViewController.LandingUserAction {
    init?(_ coordinatorAction: LandingCoordinator.LandingUserAction) {
        switch coordinatorAction {
            case .showResumeScreen:
                self = .showResumeScreen
            case .showProjectScreen:
                self = .showProjectScreen
            case .showTechSkillsScreen:
                self = .showTechSkillsScreen
        }
    }
}
