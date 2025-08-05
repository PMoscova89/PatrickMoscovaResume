//
//  Constants.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/21/25.
//

import UIKit
import CoreGraphics

struct Constants {
    
    // MARK: - General Spacing
    // General spacing
    static let paddingSmall: CGFloat = 4
    static let paddingMedium: CGFloat = 8
    static let paddingRegular: CGFloat = 12
    static let paddingLarge: CGFloat = 16
    static let paddingXLarge: CGFloat = 20
    
    // MARK: - General Font Sizes
    static let fontSize: CGFloat = 14
    static let fontSizeSmall: CGFloat = 12
    static let fontSizeXSmall: CGFloat = 10
    static let fontSizeMedium: CGFloat = 18
    static let fontSizeLarge: CGFloat = 24
    static let fontSizeXLarge: CGFloat = 32
    static let fontSizeXXLarge: CGFloat = 48
    
    
    // MARK: - General Image Sizes
    static let imageSize : CGFloat = 24
    static let imageSizeSmall : CGFloat = 16
    static let imageSizeMedium : CGFloat = 32
    static let imageSizeLarge : CGFloat = 48
    static let imageSizeXLarge: CGFloat = 64
    static let imageSizeXXLarge: CGFloat = 128
    
    // MARK: - IconTextButton
    struct IconTextButton {
        // Button-specific
        static let iconTextButtonImagePadding: CGFloat = paddingRegular
        static let iconTextButtonContentInsets = NSDirectionalEdgeInsets(top: paddingMedium, leading: paddingXLarge, bottom: paddingMedium, trailing: paddingXLarge)
        static let iconTextButtonTitleLeftInset: CGFloat = paddingLarge
        static let iconTextButtonImageLeftInset: CGFloat = paddingMedium
        static let defaultImageSize : CGFloat = 24
        static let defaultFontSize : CGFloat = 18
        static let defaultSpacing : CGFloat = 8
        
    }
    
    // MARK: Image names
    struct ImageNames {
        static let logoLabel = "logo_label"
        static let mainLogo = "mainLogo"
        static let iconWhite = "icon_white"
        static let iconBlack = "icon_black"
        static let swiftUILogo = "swift_ui_logo"
        static let swiftLogo = "swift_logo"
        
    }
    
    // MARK: Titles
    struct Titles {
        static let resumeTitle = "Patrick Moscova"
        static let swiftUIButtonTitle = "SwiftUI"
        static let swiftButtonTitle = "Swift"
    }
    
    struct Storyboards {
        static let landing = UIStoryboard(name: "Landing", bundle: nil)
        static let resume = UIStoryboard(name: "Resume", bundle: nil)
    }
    
    struct StoryboardIDS {
        static let landingViewController = "LandingViewController"
        static let resumeChoiceViewController = "ResumeChoiceViewController"
    }
 
    struct CellIDs {
        static let skillCellID = "TechnicalSkillTableViewCell"
    }
}
