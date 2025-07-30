//
//  UIViewController+display.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/29/25.
//

import UIKit

extension UIViewController {
    func display(_ viewController: UIViewController, animated: Bool = true) {
        if let nav = navigationController {
            nav.pushViewController(viewController, animated: animated)
        }else {
            present(viewController, animated: animated)
        }
    }
}
