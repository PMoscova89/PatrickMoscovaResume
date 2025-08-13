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
        let mediaController = AudioPlayerController()
        if let url = Bundle.main.url(forResource: "i-need-dollar", withExtension: "mp3") {
            mediaController.loadMedia(url: url)
        }
        let vc = MediaPlayerViewController(
            controller: mediaController,
            title: "Audio Player",
            allowedContentTypes: [.audio, .mp3, .wav, .mpeg4Audio])
    
        if let vcParent = viewController {
            display(vc, from: vcParent, animated: true)
        }else if let theParent = parent {
            display(vc, from: theParent, animated: true)
        }
    }
    
    private func showVideo() {

        let videoPlayerController = VideoPlayerController()
        if let url = Bundle.main.url(forResource: "default_movie", withExtension: "mov") {
            videoPlayerController.loadMedia(url: url)
        }
        
        let makeRenderView: () -> UIView = {
            let theView = UIView()
            theView.backgroundColor = .black
            theView.layer.cornerRadius = 8
            theView.clipsToBounds = true
            return theView
            
        }
        
        let vc = MediaPlayerViewController(
            controller:videoPlayerController,
            title: "default_movie.mov",
            allowedContentTypes: [.movie, .mpeg4Movie, .quickTimeMovie],
            renderViewProvider: makeRenderView
        )
        
        if let vcParent = viewController {
            display(vc, from: vcParent, animated: true)
        }else if let theParent = parent {
            display(vc, from: theParent, animated: true)
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
