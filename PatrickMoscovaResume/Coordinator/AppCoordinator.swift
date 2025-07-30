//
//  AppCoordinator.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/29/25.
//

import UIKit

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController? = nil
    private var landingCoordinator: LandingCoordinator?
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        // Create a nav controller to drive Landing
        let navigationController = UINavigationController()
        
        // Initialize LandingCoordinator with navController
        let landingCoordinator = LandingCoordinator(navigationController: navigationController)
        self.landingCoordinator = landingCoordinator
        
        // Set navController as root of window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // Start Landing flow
        landingCoordinator.start()

    }
    
    func stop() {
        
    }
}
