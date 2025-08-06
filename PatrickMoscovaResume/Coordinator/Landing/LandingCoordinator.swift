//
//  LandingCoordinator.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/28/25.
//

import UIKit
class LandingCoordinator: Coordinator {
    
    enum LandingUserAction : UserAction {
        case showResumeScreen
        case showProjectScreen
        case showTechSkillsScreen
    }
    
    private weak var navigationController: UINavigationController?
    private weak var landingViewController: LandingViewController?
    private var technicalSkillsCoordinator: TechnicalSkillsCoordinator?
    
    private var window: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let navController = navigationController else {
            assertionFailure("No Navigation Controller for Landing Coordinator")
            return
        }
        let storyboard = Constants.Storyboards.landing
        guard let landingVC = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIDS.landingViewController ) as? LandingViewController else {
            return
        }
        landingVC.coordinator = self
        landingViewController = landingVC
        
        
        if let navController = navigationController {
            navigationController?.setViewControllers([landingVC], animated: true)
        }else if let theWindow = window{
            theWindow.rootViewController = landingViewController
            theWindow.makeKeyAndVisible()
        }
    }
    
    func stop() {
        
    }
    
    func handle(action: any UserAction) {
        guard let viewControllerAction = action as? LandingViewController.LandingUserAction else {
            return
        }
        guard let coordinatorAction = LandingUserAction(viewControllerAction) else {
            return
        }
        switch coordinatorAction {
            case .showProjectScreen:
                print("projectScreen")
            case .showResumeScreen:
                print("showResumeScreen")
                showResume()
            case .showTechSkillsScreen:
                print("show Tech Skills")
                showTechSkillsSelection()
        }
    }
    
    
}

//MARK: Action Extensions
extension LandingCoordinator {
    @objc
    func showResume() {
        let storyboard = Constants.Storyboards.resume
        guard let resumeVC = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardIDS.resumeChoiceViewController) as? ResumeChoiceViewController else {
            return
        }
        if let landingVC = landingViewController {
            display(resumeVC, from: landingVC)
        }
    }
    @objc
    func showTechSkillsSelection() {
        if let navigationController = navigationController {
            technicalSkillsCoordinator = TechnicalSkillsCoordinator(navigationController: navigationController)
        }
        technicalSkillsCoordinator?.start()
      
        
    }
}
