//
//  TechnicalSkillsViewControllerTests.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/5/25.
//


import XCTest
@testable import PatrickMoscovaResume

final class TechnicalSkillsViewControllerTests: XCTestCase {
    
    var skillsViewController: TechnicalSkillsViewController!

    override func setUp() {
        super.setUp()
        skillsViewController = TechnicalSkillsViewController()
        skillsViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        skillsViewController = nil
        super.tearDown()
    }

    func test_numberOfRows_matchesNumberOfTechnicalSkills() {
        let tableView = skillsViewController.view.subviews.compactMap { $0 as? UITableView }.first!
        let count = skillsViewController.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(count, TechnicalSkill.allCases.count)
    }

    func test_cellForRow_setsCorrectLabelAndIcon() {
        let tableView = skillsViewController.view.subviews.compactMap { $0 as? UITableView }.first!
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = skillsViewController.tableView(tableView, cellForRowAt: indexPath)

        let expectedSkill = TechnicalSkill.allCases[0]
        XCTAssertEqual(cell.textLabel?.text, expectedSkill.rawValue)
        if let iconName = expectedSkill.iconName {
            XCTAssertEqual(cell.imageView?.image, UIImage(systemName: iconName))
        }
    }

    func test_didSelectRowAt_triggersOnSkillSelectedClosure() {
        let tableView = skillsViewController.view.subviews.compactMap { $0 as? UITableView }.first!
        let indexPath = IndexPath(row: 1, section: 0)
        
        var selectedSkill: TechnicalSkill?
        skillsViewController.onSkillSelected = { skill in
            selectedSkill = skill
        }

        skillsViewController.tableView(tableView, didSelectRowAt: indexPath)

        XCTAssertEqual(selectedSkill, TechnicalSkill.allCases[indexPath.row])
    }
}
