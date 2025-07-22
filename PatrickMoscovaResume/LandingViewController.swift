//
//  ViewController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/21/25.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var resumeButton: IconTextButton!
    @IBOutlet weak var projectsButton: IconTextButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }

    @IBAction func resumeButtonTapped(_ sender: Any) {
    }
    
    @IBAction func projectsButtonTapped(_ sender: Any) {
    }
}

extension LandingViewController {
    
    fileprivate func setupViews() {
        resumeButton.configure(imageName: Constants.ImageNames.logoLabel, title: "Resume")
        projectsButton.configure(imageName: Constants.ImageNames.logoLabel, title: "Projects")
    }
}

