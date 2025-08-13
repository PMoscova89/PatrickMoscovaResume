//
//  UIView+PlayerLayerHost.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/13/25.
//

import UIKit
import AVFoundation
import ObjectiveC

private var kPlayerLayerKey: UInt8 = 0

extension UIView {
    /// A retained AVPlayerLayer attached to this view (created on first access).
    var hostedPlayerLayer: AVPlayerLayer {
        if let existing = objc_getAssociatedObject(self, &kPlayerLayerKey) as? AVPlayerLayer {
            return existing
        }
        let layer = AVPlayerLayer()
        layer.videoGravity = .resizeAspect
        layer.needsDisplayOnBoundsChange = true
        self.layer.addSublayer(layer)
        objc_setAssociatedObject(self, &kPlayerLayerKey, layer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return layer
    }
    
    /// Call from `viewDidLayoutSubviews` (or right after constraints) to keep sizing correct.
    func layoutHostedPlayerLayer() {
        hostedPlayerLayer.frame = bounds
    }
}
