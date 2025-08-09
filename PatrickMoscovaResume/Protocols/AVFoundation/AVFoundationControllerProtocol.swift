//
//  AVFoundationControllerProtocol.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/6/25.
//


import Foundation

protocol AVFoundationControllerProtocol: AnyObject {
    var delegate: AVFoundationControllerDelegate? { get set }
    
    func performUserAction(_ action: AVFoundationUserAction)
}
