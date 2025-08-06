//
//  SkillDetailStubViewController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/3/25.
//

import UIKit
class SkillDetailStubViewController : UIViewController {
    private let skillName: TechnicalSkill
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(skillName: TechnicalSkill) {
        self.skillName = skillName
        super.init(nibName: nil, bundle: nil)
        title = skillName.rawValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .myBackground
        setupLabel()
    }
    
}

extension SkillDetailStubViewController {
    fileprivate func setupLabel() {
        
        let label = UILabel()
        label.text = "This is a stub view for \(skillName.rawValue)"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        
    }
}
