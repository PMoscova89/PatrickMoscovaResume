//
//  AVFoundationCoordinator.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/8/25.
//

import UIKit

final class AVFoundationCoordinator: Coordinator {
    
    //MARK: - Dependencies
    private weak var parent: UIViewController?
    private var controller: AVFoundationControllerProtocol
    private weak var viewController : AVFoundationFeatureViewController?
    
    //MARK: - Init
    init(parent: UIViewController? = nil, controller: AVFoundationControllerProtocol = AVFoundationController()) {
        self.parent = parent
        self.controller = controller
    }
    
    //MARK: - Coordinator
    func start() {
        controller.delegate = self
        let vc = AVFoundationFeatureViewController(controller: controller)
        vc.title = TechnicalSkill.avFoundation.rawValue
        self.viewController = vc
        if let theParent = parent {
            display(vc, from: theParent, animated: true)
        }
    }
    
    func stop() {
        controller.delegate = nil
        viewController = nil
    }
    
    private func showAudio() {
        
        let audioPlayerViewController = UIViewController() //AudioPlayerViewController()
        audioPlayerViewController.view.backgroundColor = .red
        if let vc = viewController {
            display(audioPlayerViewController, from: vc, animated: true)
        }else if let theParent = parent {
            display(audioPlayerViewController, from: theParent, animated: true)
        }
    }
    
    private func showVideo() {
        let videoPlayerViewController = UIViewController() //VideoPlayerViewcontroller()
        videoPlayerViewController.view.backgroundColor = .green
        if let vc = viewController {
            display(videoPlayerViewController, from: vc, animated: true)
        }else if let theParent = parent {
            display(videoPlayerViewController, from: theParent, animated: true)
        }
    }
    
    private func showImageCropper() {
        let imageCropperViewController = UIViewController() // ImageCropperViewController()
        imageCropperViewController.view.backgroundColor = .blue
        if let vc = viewController {
            display(imageCropperViewController, from: vc, animated: true)
        }else if let theParent = parent {
            display(imageCropperViewController, from: theParent, animated: true)
        }
    }
    
}

extension AVFoundationCoordinator : AVFoundationControllerDelegate {
    func didRequestAudioPlayback() {
        showAudio()
    }
    func didRequestVideoPlayback() {
        showVideo()
    }
    func didRequestImageCropping() {
        showImageCropper()
    }
}
