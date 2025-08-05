//
//  TechnicalSkillsViewController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/3/25.
//

import UIKit

class TechnicalSkillsViewController: UIViewController {
    
    private let tableView = UITableView()
    private let technicalSkills = TechnicalSkill.allCases
    
    public var onSkillSelected: ((TechnicalSkill) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Technical Skills"
        view.backgroundColor = .myBackground
        setupTableView()
    }
    
    
    
}

//MARK: UITableView

extension TechnicalSkillsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let skill = technicalSkills[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIDs.skillCellID, for: indexPath)
        cell.textLabel?.text = skill.rawValue
        cell.accessoryType = .disclosureIndicator
        if let iconName = skill.iconName {
            cell.imageView?.image = UIImage(systemName: iconName)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return technicalSkills.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellIDs.skillCellID)
        tableView.delegate = self
        tableView.dataSource = self
    }
}



    
   
