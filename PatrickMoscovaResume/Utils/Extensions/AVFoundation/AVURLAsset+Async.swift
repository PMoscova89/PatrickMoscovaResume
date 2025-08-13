//
//  AVURLAsset+Async.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/13/25.
//

import AVFoundation



extension AVAsset {
    func prepareForPlayback() async throws {
        if #available(iOS 16, *) {
            _ = try await self.load(.isPlayable)
            _ = try await self.load(.tracks)
            _ = try await self.load(.duration)
            return
        }
        
        // Legacy path (iOS 15 and earlier)
        guard let urlAsset = self as? AVURLAsset else { return }
        let keys = ["playable", "duration", "tracks"]
        
        try await withCheckedThrowingContinuation { (cont: CheckedContinuation<Void, Error>) in
            urlAsset.loadValuesAsynchronously(forKeys: keys) {
                for key in keys {
                    var err: NSError?
                    let status = urlAsset.statusOfValue(forKey: key, error: &err)
                    guard status == .loaded else {
                        cont.resume(throwing: err ?? NSError(domain: "AVLoad", code: -1))
                        return
                    }
                }
                cont.resume(returning: ())   // ← explicit Void
            }
        }
    }
    
    var safeDurationSeconds: Double? {
        let s = duration.seconds
        return s.isFinite ? s : nil
    }
}
