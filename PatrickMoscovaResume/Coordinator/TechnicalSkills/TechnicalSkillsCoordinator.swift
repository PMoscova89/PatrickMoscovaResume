//
//  TechnicalSkillsCoordinator.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/5/25.
//

import UIKit

class TechnicalSkillsCoordinator: Coordinator {
    private let navigationController : UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let skillsViewController = TechnicalSkillsViewController()
        skillsViewController.onSkillSelected = { [weak self] in
            self?.showDetail(for: $0)
        }
        navigationController.pushViewController(skillsViewController, animated: true)
    }
    func stop() {
        navigationController.popViewController(animated: true)
    }
    
    func showDetail(for skill: TechnicalSkill) {
        let detailVC = SkillDetailStubViewController(skillName: skill)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
