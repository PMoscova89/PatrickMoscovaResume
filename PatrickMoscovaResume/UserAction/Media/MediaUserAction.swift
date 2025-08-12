//
//  MediaUserAction.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/11/25.
//

import Foundation


enum MediaUserAction: Equatable {
    case play
    case pause
    case importFile
    case scrubBegan
    case scrubEnded
    case seek(toSeconds: TimeInterval)
    
}
