//
//  MediaPlayerViewController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/11/25.
//

import UIKit
import UniformTypeIdentifiers

final class MediaPlayerViewController: UIViewController {
    
    private let controller: MediaPlayerControllerProtocol
    private let controls = MediaPlayerControlsView()
    private let renderViewProvider: ( () -> UIView)?
    private let allowedContentTypes: [UTType]
    private var renderView: UIView?
    
    init(controller: MediaPlayerControllerProtocol,
         title: String = TechnicalSkill.avFoundation.rawValue,
         allowedContentTypes: [UTType],
         renderViewProvider: (() -> UIView)? = nil) {
        self.controller = controller
        self.renderViewProvider = renderViewProvider
        self.allowedContentTypes = allowedContentTypes
        super.init(nibName: nil, bundle: nil)
        self.controller.delegate = self
        self.title = title
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .myBackground
        layoutViews()
        wireUpControls()
    }
    
    
}

//MARK: - Layout
extension MediaPlayerViewController {
    private func layoutViews() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = Constants.paddingLarge
        container.translatesAutoresizingMaskIntoConstraints = false
        
        if let makeRenderView = renderViewProvider {
            let v = makeRenderView()
            v.translatesAutoresizingMaskIntoConstraints = false
            renderView = v
            container.addArrangedSubview(v)
            v.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
            controller.attachRenderView(v)
        }
        container.addArrangedSubview(controls)
        view.addSubview(container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: Constants.paddingLarge),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -Constants.paddingLarge),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
    private func wireUpControls() {
        controls.importButton.addTarget(self, action: #selector(importTapped), for: .touchUpInside)
        controls.playPauseButton.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        controls.slider.addTarget(self, action: #selector(scrubBegan), for: .touchDown)
        controls.slider.addTarget(self, action: #selector(scrubEnded), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        controls.slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
    }
}

//MARK: - Actions. The Interface kind.


extension MediaPlayerViewController {
    @objc private func importTapped() {
        let mediaPicker = UIDocumentPickerViewController(forOpeningContentTypes: allowedContentTypes)
        mediaPicker.delegate = self
        present(mediaPicker, animated: true)
    }
    
    @objc private func playPauseTapped() {
        controller.handle(controller.isPlaying ? .pause : .play)
    }
    
    @objc private func scrubBegan() {
        controller.handle(.scrubBegan)
    }
    
    @objc private func scrubEnded() {
        controller.handle(.scrubEnded)
        if let duration = controller.duration {
            let target = TimeInterval(controls.slider.value) * duration
            controller.handle(.seek(toSeconds: target))
        }
    }
    
    @objc private func sliderChanged() {
        if let duration = controller.duration {
            let target = TimeInterval(controls.slider.value) * duration
            controls.timeLabel.text = "\(TimeFormatting.mmss(target)) / \(TimeFormatting.mmss(duration))"
        }
    }
}

//MARK: UIDocumentPickerDelegate
extension MediaPlayerViewController: UIDocumentPickerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        if url.startAccessingSecurityScopedResource() {
            defer {
                url.stopAccessingSecurityScopedResource()
            }
        }
        self.controller.loadMedia(url: url)
    }
}

extension MediaPlayerViewController : MediaPlayerControllerDelegate {
    func mediaPlayerDidLoadDuration(_ duration: TimeInterval) {
        controls.slider.isEnabled = true
        controls.slider.value = 0
        controls.timeLabel.text = "00:00 / \(TimeFormatting.mmss(duration))"
        controls.playPauseButton.isEnabled = true
    }
    
    func mediaDidUpdateProgress(_ currentTime: TimeInterval) {
        guard let duration = controller.duration, duration > 0 else { return }
        controls.slider.value = Float(currentTime / duration)
        controls.timeLabel.text = "\(TimeFormatting.mmss(currentTime)) / \(TimeFormatting.mmss(duration))"
    }
    
    func mediaPlaybackStatusDidChange(isPlaying: Bool) {
        controls.playPauseButton.setTitle(isPlaying ? Constants.MediaPlayer.Strings.pauseTitle : Constants.MediaPlayer.Strings.playTitle, for: .normal)
    }
    
    func mediaDidFail(_ error: any Error) {
        let alertController = UIAlertController(title: "Error", message: "\(error)\n\(error.localizedDescription)", preferredStyle: .alert)
        
        // Add an action (button) to the alert
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("OK tapped")
        })
        
        // Add the action to the alert controller
        alertController.addAction(okAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
}

//MARK: for testing

extension MediaPlayerViewController {
#if DEBUG
    /// Exposes the controls view only in debug/test builds
    var controlsForTesting: MediaPlayerControlsView { controls }
#endif
}
