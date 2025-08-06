//
//  SpyNavigationController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/6/25.
//


import UIKit

final class SpyNavigationController: UINavigationController {
    private(set) var didPushViewController = false
    private(set) var didPopViewController = false
    private(set) var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        didPushViewController = true
        pushedViewController = viewController
        super.pushViewController(viewController, animated: false)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        didPopViewController = true
        return super.popViewController(animated: false)
    }
}
