//
//  MediaPlayerViewController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/11/25.
//

import UIKit
import UniformTypeIdentifiers
import AVFoundation
final class MediaPlayerViewController: UIViewController {
    
    private let controller: MediaPlayerControllerProtocol
    private let controls = MediaPlayerControlsView()
    private let renderViewProvider: ( () -> UIView)?
    private let allowedContentTypes: [UTType]
    private var renderView: UIView?
    private var didAutoLoadDemo: Bool = false
    private var isScrubbing = false
    private var wasPlayingBeforeScrubbing: Bool = false
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let rv = renderView {
            rv.layer.sublayers?
                .compactMap{ $0 as? AVPlayerLayer }
                .forEach { $0.frame = rv.bounds}
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard didAutoLoadDemo == false else { return }
        let isVideoFlow = allowedContentTypes.contains{
            $0.conforms(to: .movie) || $0.conforms(to: .audiovisualContent)
        }
        guard isVideoFlow else {
            print("is not video flow")
            return
        }
        if let url = Bundle.main.url(forResource: "default_movie", withExtension: "mov", subdirectory: "Resources/Video") {
            didAutoLoadDemo = true
            controller.loadMedia(url: url)
        }
        
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
            v.heightAnchor.constraint(equalTo: v.widthAnchor, multiplier: 9/16).isActive = true
            controller.attachRenderView(v)
        }
        container.addArrangedSubview(controls)
        view.addSubview(container)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: guide.leadingAnchor,
                                               constant: Constants.paddingLarge),
            container.trailingAnchor.constraint(equalTo: guide.trailingAnchor,
                                                constant: -Constants.paddingLarge),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: Constants.paddingLarge),
            container.heightAnchor.constraint(equalTo: guide.heightAnchor, constant: 0.5)
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
        isScrubbing = true
        wasPlayingBeforeScrubbing = controller.isPlaying
        if wasPlayingBeforeScrubbing {
            controller.handle(.pause)
        }
        controller.handle(.scrubBegan)
    }
    
    @objc private func scrubEnded() {
        controller.handle(.scrubEnded)
        guard let duration = controller.duration else {
            isScrubbing = false
            return
        }
        let target = TimeInterval(controls.slider.value) * duration
        controller.handle(.seek(toSeconds: target))
        controls.timeLabel.text = "\(TimeFormatting.mmss(target)) / \(TimeFormatting.mmss(duration))"
        if wasPlayingBeforeScrubbing {
            controller.handle(.play)
        }
        isScrubbing = false
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
        guard isScrubbing == false else { return }
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
