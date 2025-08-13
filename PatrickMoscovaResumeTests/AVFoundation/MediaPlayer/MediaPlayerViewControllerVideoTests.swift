//
//  MediaPlayerViewControllerVideoTests.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/13/25.
//

import XCTest
import UniformTypeIdentifiers
@testable import PatrickMoscovaResume

final class MediaPlayerViewControllerVideoTests: XCTestCase {

    // MARK: - Fixtures
    private var fake: MockMediaController!
    private var theViewController: MediaPlayerViewController!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        fake = MockMediaController()
        theViewController = makeVideoVC(fake: fake)
    }

    override func tearDown() {
        theViewController = nil
        fake = nil
        super.tearDown()
    }

    // MARK: - Factory
    private func makeVideoVC(fake: MockMediaController,
                             title: String = "Video Player",
                             allowed: [UTType] = [.movie]) -> MediaPlayerViewController {
        // Give VC a host view to attach the AVPlayerLayer to
        let host = UIView()
        host.accessibilityIdentifier = "render_host"
        let vc = MediaPlayerViewController(
            controller: fake,
            title: title,
            allowedContentTypes: allowed,
            renderViewProvider: { host }
        )
        _ = vc.view // force load
        return vc
    }

    // MARK: - Helpers
    private func controls(_ vc: MediaPlayerViewController) -> MediaPlayerControlsView {
        #if DEBUG
        return vc.controlsForTesting
        #else
        return findControls(in: vc.view) ?? { fatalError("MediaPlayerControlsView not found") }()
        #endif
    }

    private func findControls(in root: UIView?) -> MediaPlayerControlsView? {
        guard let root else { return nil }
        if let c = root as? MediaPlayerControlsView { return c }
        if root.accessibilityIdentifier == "media_controls", let c = root as? MediaPlayerControlsView { return c }
        for sub in root.subviews { if let found = findControls(in: sub) { return found } }
        return nil
    }

    private func findRenderHost(in root: UIView?) -> UIView? {
        guard let root else { return nil }
        if root.accessibilityIdentifier == "render_host" { return root }
        for sub in root.subviews { if let v = findRenderHost(in: sub) { return v } }
        return nil
    }

    // MARK: - Tests

    func test_hasRenderView_forVideoFlow() {
        // given
        theViewController = makeVideoVC(fake: fake)

        // then
        XCTAssertNotNil(findRenderHost(in: theViewController.view),
                        "Video flow should include a render host view for AVPlayerLayer.")
    }

    func test_playPauseButton_togglesPlayWhenInitiallyPaused_video() {
        // given
        fake.isPlaying = false
        theViewController = makeVideoVC(fake: fake)

        // when
        theViewController.perform(Selector(("playPauseTapped")))

        // then
        XCTAssertEqual(fake.lastAction, .play)
        XCTAssertTrue(fake.isPlaying)
    }

    func test_playPauseButton_togglesPauseWhenPlaying_video() {
        // given
        fake.isPlaying = true
        theViewController = makeVideoVC(fake: fake)

        // when
        theViewController.perform(Selector(("playPauseTapped")))

        // then
        XCTAssertEqual(fake.lastAction, .pause)
        XCTAssertFalse(fake.isPlaying)
    }

    func test_slider_scrubEnded_seeksToExpectedTime_video() {
        // given
        fake.duration = 200
        theViewController = makeVideoVC(fake: fake)
        let c = controls(theViewController)
        c.slider.minimumValue = 0
        c.slider.maximumValue = 1
        c.slider.value = 0.5 // halfway

        // when
        theViewController.perform(Selector(("scrubEnded")))

        // then
        guard case let .seek(t)? = fake.lastAction else {
            return XCTFail("Expected last action .seek")
        }
        XCTAssertEqual(t, 100, accuracy: 0.001)
        XCTAssertEqual(fake.currentTime, 100, accuracy: 0.001)
    }

    func test_delegate_loadDuration_updatesUI_video() {
        // given
        theViewController = makeVideoVC(fake: fake)

        // when
        fake.delegate?.mediaPlayerDidLoadDuration(90)

        // then
        let c = controls(theViewController)
        XCTAssertEqual(c.slider.value, 0)
        XCTAssertTrue(c.timeLabel.text?.contains("1:30") == true)
    }

    func test_delegate_updateProgress_movesSlider_video() {
        // given
        fake.duration = 100
        theViewController = makeVideoVC(fake: fake)

        // when
        fake.delegate?.mediaDidUpdateProgress(40)

        // then
        let c = controls(theViewController)
        XCTAssertEqual(c.slider.value, 0.4, accuracy: 0.001)
        XCTAssertTrue(c.timeLabel.text?.contains("0:40") == true)
    }
}
