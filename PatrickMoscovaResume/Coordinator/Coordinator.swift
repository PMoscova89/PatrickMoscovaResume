//
//  Coordinator.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/28/25.
//

import UIKit
protocol Coordinator: AnyObject {
    func start()
    func stop()
    func handle(action: UserAction)
    func display(_ viewController: UIViewController, from parent: UIViewController, animated: Bool)
}

extension Coordinator {
    func handle(action: UserAction) {}
    func display(_ viewController: UIViewController, from parent: UIViewController, animated: Bool = true) {
        if let navVC = (parent as? UINavigationController) ?? parent.navigationController {
            navVC.pushViewController(viewController, animated: animated)
        }else {
            parent.present(viewController, animated: animated)
        }
    }
}
