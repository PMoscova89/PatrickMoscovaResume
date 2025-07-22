//
//  UIImage+resize.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/22/25.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
