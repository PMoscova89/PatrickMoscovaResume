//
//  IconTextButton.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/22/25.
//


import UIKit

class IconTextButton: UIButton {

    func configure(
        imageName: String,
        title: String,
        imageSize: CGFloat = Constants.IconTextButton.defaultImageSize,
        font: UIFont = .systemFont(ofSize: Constants.IconTextButton.defaultFontSize),
        imageColor: UIColor? = nil, // Optional: tint
        spacing: CGFloat = Constants.IconTextButton.defaultSpacing
    ) {
        setTitle(title, for: .normal)
        titleLabel?.font = font

        // 1. Try SF Symbol first, else asset image
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: imageSize, weight: .regular)
        var image: UIImage?
        var isSymbol = false
        if let sf = UIImage(systemName: imageName, withConfiguration: symbolConfig) {
            image = sf
            isSymbol = true
        } else if let asset = UIImage(named: imageName) {
            let resizedImage = asset.resized(to: CGSize(width: imageSize, height: imageSize))
            //image = asset
            image = resizedImage
        }

        // 2. Set up for iOS 15+ (UIButton.Configuration)
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.title = title
            config.baseForegroundColor = tintColor // Or any desired color
            config.image = image
            config.imagePlacement = .leading
            config.imagePadding = spacing
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
                var newAttributes = attributes
                newAttributes.font = font
                return newAttributes
            }

            // Icon color/tinting
            if let imageColor = imageColor {
                config.baseForegroundColor = imageColor
            }

            self.configuration = config

        } else {
            // iOS 14 and below: classic setup
            setImage(image, for: .normal)
            semanticContentAttribute = .forceLeftToRight
            contentHorizontalAlignment = .leading

            // Tint if needed
            if let imageColor = imageColor, isSymbol || image?.renderingMode == .alwaysTemplate {
                tintColor = imageColor
                setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
            } else {
                tintColor = .clear
                setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            }

            imageView?.contentMode = .scaleAspectFit

            // Spacing between image and text
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)

            // Size the imageView for assets
            if let imageView = self.imageView {
                imageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.deactivate(imageView.constraints)
                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(equalToConstant: imageSize),
                    imageView.heightAnchor.constraint(equalToConstant: imageSize)
                ])
            }
        }
    }
}
