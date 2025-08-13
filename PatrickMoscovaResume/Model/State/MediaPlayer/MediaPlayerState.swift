//
//  MediaPlayerState.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/12/25.
//

import Foundation
import Combine

final class MediaPlayerState: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var duration: TimeInterval? = nil
    @Published var currentTime: TimeInterval? = nil
    @Published var error: Error? = nil
    
}
