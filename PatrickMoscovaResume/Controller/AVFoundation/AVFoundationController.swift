//
//  AVFoundationController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/6/25.
//


import Foundation

final class AVFoundationController: AVFoundationControllerProtocol {
    
    // MARK: - Dependencies
    
    weak var delegate: AVFoundationControllerDelegate?

    // MARK: - Init
    
    init() {
        // Any future injected services go here
    }

    // MARK: - User Actions
    
    func performUserAction(_ action: AVFoundationUserAction) {
        switch action {
        case .audioTapped:
            print("🔊 Audio button tapped")
             delegate?.didRequestAudioPlayback()
        case .videoTapped:
            print("🎥 Video button tapped")
             delegate?.didRequestVideoPlayback()
        case .imageCropperTapped:
            print("✂️ Image Cropper button tapped")
             delegate?.didRequestImageCropping()
        }
    }
}
