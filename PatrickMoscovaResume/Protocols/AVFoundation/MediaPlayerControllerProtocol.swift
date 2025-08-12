//
//  MediaPlayerControllerProtocol.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/11/25.
//

import Foundation
import UIKit

protocol MediaPlayerControllerProtocol: AnyObject {
    var delegate: MediaPlayerControllerDelegate? { get set }
    var isPlaying: Bool { get }
    var duration: TimeInterval? { get }
    var currentTime: TimeInterval { get }
    
    func loadMedia(url: URL)
    func handle(_ action: MediaUserAction)
    
    func attachRenderView(_ view: UIView)
}

extension MediaPlayerControllerProtocol {
    func attachRenderView(_ view: UIView) {}
}
