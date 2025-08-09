//
//  MockAVFoundationController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/8/25.
//

import Foundation
@testable import PatrickMoscovaResume

final class MockAVFoundationController: AVFoundationControllerProtocol {
    weak var delegate: (any AVFoundationControllerDelegate)?
    private(set) var lastAction: AVFoundationUserAction?
    private(set) var performUserActionCallCount = 0
    
    func performUserAction(_ action: AVFoundationUserAction) {
        lastAction = action
        performUserActionCallCount += 1
    }
    
    //MARK: - Validation vars
    var didReceiveAudioTap: Bool { lastAction == .audioTapped }
    var didReceiveVideoTap: Bool { lastAction == .videoTapped }
    var didReceiveImageCropperTap: Bool { lastAction == .imageCropperTapped }
    
    func reset() { lastAction = nil; performUserActionCallCount = 0 }
}
