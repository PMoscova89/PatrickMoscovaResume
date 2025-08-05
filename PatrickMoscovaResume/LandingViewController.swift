//
//  ViewController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/21/25.
//

import UIKit

class LandingViewController: UIViewController {

    enum LandingUserAction : UserAction {
        case showResumeScreen
        case showProjectScreen
        case showTechSkillsScreen
    }
    
    @IBOutlet weak var resumeButton: IconTextButton!
    @IBOutlet weak var projectsButton: IconTextButton!
    
    @IBOutlet weak var technicalSkillsButton: IconTextButton!
    weak var coordinator: LandingCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }

    @IBAction func resumeButtonTapped(_ sender: Any) {
        coordinator?.handle(action: LandingUserAction(.showResumeScreen) ?? .showResumeScreen)
    }
    
    @IBAction func projectsButtonTapped(_ sender: Any) {
    }
    
    @IBAction func technicalSkillButtonTapped(_ sender: Any) {
        coordinator?.handle(action: LandingUserAction(.showTechSkillsScreen) ?? .showTechSkillsScreen)
    }
    
}

extension LandingViewController {
    
    fileprivate func setupViews() {
        resumeButton.configure(imageName: Constants.ImageNames.logoLabel, title: "Resume")
        projectsButton.configure(imageName: Constants.ImageNames.logoLabel, title: "Projects")
        technicalSkillsButton.configure(imageName: Constants.ImageNames.swiftLogo, title: "Technical Skills")
    }
    
}


