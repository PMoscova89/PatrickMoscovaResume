//
//  Constants.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/21/25.
//

import UIKit
import CoreGraphics

struct Constants {
    // General spacing
    static let paddingSmall: CGFloat = 4
    static let paddingMedium: CGFloat = 8
    static let paddingRegular: CGFloat = 12
    static let paddingLarge: CGFloat = 16
    static let paddingXLarge: CGFloat = 20
    
    struct IconTextButton {
        // Button-specific
        static let iconTextButtonImagePadding: CGFloat = paddingRegular
        static let iconTextButtonContentInsets = NSDirectionalEdgeInsets(top: paddingMedium, leading: paddingXLarge, bottom: paddingMedium, trailing: paddingXLarge)
        static let iconTextButtonTitleLeftInset: CGFloat = paddingLarge
        static let iconTextButtonImageLeftInset: CGFloat = paddingMedium
    }
    
    struct ImageNames {
        static let logoLabel = "logo_label"
        static let mainLogo = "mainLogo"
        static let iconWhite = "icon_white"
        static let iconBlack = "icon_black"
    }
 
}
