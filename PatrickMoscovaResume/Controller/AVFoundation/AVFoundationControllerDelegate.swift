//
//  AVFoundationControllerDelegate.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/6/25.
//


import Foundation

protocol AVFoundationControllerDelegate: AnyObject {
    // Add delegate methods here if needed in the future
    func didRequestAudioPlayback()
    func didRequestVideoPlayback()
    func didRequestImageCropping()
}
