//
//  MediaPlayerControls.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/11/25.
//

import UIKit

final class MediaPlayerControlsView: UIView {
    let importButton = UIButton(type: .system)
    let playPauseButton = UIButton(type: .system)
    let slider = UISlider()
    let timeLabel = UILabel()
    
    override init( frame: CGRect ) {
        super.init( frame: frame )
        setupViews()
    }
    
    override required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        accessibilityIdentifier = "media_controls"
        importButton.setTitle(Constants.MediaPlayer.Strings.importTitle, for: .normal)
        playPauseButton.setTitle(Constants.MediaPlayer.Strings.playTitle, for: .normal)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.isContinuous = true
        timeLabel.textAlignment = .center
        timeLabel.text = "00:00 / 00:00"
        
        let theStack = UIStackView(arrangedSubviews: [importButton, playPauseButton, slider, timeLabel])
        theStack.axis = .vertical
        theStack.spacing = Constants.MediaPlayer.stackSpacing
        theStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(theStack)
        
        NSLayoutConstraint.activate([
            theStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            theStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            theStack.topAnchor.constraint(equalTo: topAnchor),
            theStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
}
