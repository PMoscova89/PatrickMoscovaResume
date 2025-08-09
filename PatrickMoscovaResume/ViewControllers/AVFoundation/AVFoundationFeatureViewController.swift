//
//  AVFoundationFeatureViewController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/6/25.
//

import UIKit
final class AVFoundationFeatureViewController: UIViewController {
    private let controller: AVFoundationControllerProtocol
    
    private lazy var audioButton: UIButton = {
        let button = makeButton("Play Audio")
        button.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        return button
    }()
    
    private lazy var videoButton: UIButton = {
        let button = makeButton( "Play Video" )
        button.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        return button
    }()
    
    private lazy var cropperButton: UIButton = {
        let button = makeButton("Crop Image")
        button.addTarget(self, action: #selector(cropImage), for: .touchUpInside)
        return button
    }()
    
    init(controller: AVFoundationControllerProtocol) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
    
    
    //MARK: helpers
    
    private func makeButton(_ buttonTitle: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.fontSizeXLarge, weight: .medium)
        button.backgroundColor = .tertiarySystemFill
        button.setTitleColor(.myLabel, for: .normal)
        button.layer.cornerRadius = 21
        button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        return button
    }
    
    private func setupLayout() {
        
        view.backgroundColor = .myBackground
        let stack = UIStackView(arrangedSubviews: [
            audioButton,
            videoButton,
            cropperButton
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.paddingXXLarge),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.paddingXXLarge),
            stack.heightAnchor.constraint(equalToConstant: Constants.buttonHeight * CGFloat(stack.arrangedSubviews.count) + Constants.paddingSmall)
        ])
    }
    //MARK: Actions
    
    @objc private func playAudio() {
        controller.performUserAction(.audioTapped)
    }
    
    @objc private func playVideo() {
        controller.performUserAction(.videoTapped)
    }
    
    @objc private func cropImage() {
        controller.performUserAction(.imageCropperTapped)
    }
    
    
    
}
