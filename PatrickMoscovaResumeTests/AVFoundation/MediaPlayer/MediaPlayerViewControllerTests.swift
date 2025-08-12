//
//  MediaPlayerViewControllerTests.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/11/25.
//

import XCTest
import UniformTypeIdentifiers
@testable import PatrickMoscovaResume

final class MediaPlayerViewControllerTests: XCTestCase {
    
    // MARK: - Test Fixtures
    private var fake: MockMediaController!
    private var theViewController: MediaPlayerViewController!
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        fake = MockMediaController()
        theViewController = makeViewController(fake: fake)
    }
    
    override func tearDown() {
        theViewController = nil
        fake = nil
        super.tearDown()
    }
    
    // MARK: - Factory
    private func makeViewController(fake: MockMediaController,
                                    title: String = "Audio Player",
                                    allowed: [UTType] = [.audio]) -> MediaPlayerViewController {
        let theController = MediaPlayerViewController(
            controller: fake,
            title: title,
            allowedContentTypes: allowed,
            renderViewProvider: nil // audio: no render view
        )
        _ = theController.view // force load
        return theController
    }
    
    // MARK: - Helpers
    private func controls(_ vc: MediaPlayerViewController) -> MediaPlayerControlsView {
        // Access internal controls via KVC for testing
#if DEBUG
        return vc.controlsForTesting
#else
        // Fallback approach if DEBUG accessor is not available
        // (search the view hierarchy by accessibilityIdentifier)
        return findControls(in: vc.view) ?? {
            fatalError("MediaPlayerControlsView not found")
        }()
#endif
    }
    
    
    private func findControls(in root: UIView?) -> MediaPlayerControlsView? {
        guard let root else { return nil }
        if let c = root as? MediaPlayerControlsView { return c }
        if root.accessibilityIdentifier == "media_controls", let c = root as? MediaPlayerControlsView { return c }
        for sub in root.subviews { if let found = findControls(in: sub) { return found } }
        return nil
    }
    
    // MARK: - Tests
    func test_playPauseButton_togglesPlayWhenInitiallyPaused() {
        // given
        fake.isPlaying = false
        theViewController = makeViewController(fake: fake)
        
        // when
        theViewController.perform(Selector(("playPauseTapped")))
        
        // then
        XCTAssertEqual(fake.lastAction, .play)
        XCTAssertTrue(fake.isPlaying)
    }
    
    func test_playPauseButton_togglesPauseWhenPlaying() {
        // given
        fake.isPlaying = true
        theViewController = makeViewController(fake: fake)
        
        // when
        theViewController.perform(Selector(("playPauseTapped")))
        
        // then
        XCTAssertEqual(fake.lastAction, .pause)
        XCTAssertFalse(fake.isPlaying)
    }
    
    func test_slider_scrubEnded_seeksToExpectedTime() {
        // given
        fake.duration = 120 // 2 minutes
        theViewController = makeViewController(fake: fake)
        let c = controls(theViewController)
        c.slider.value = 0.25 // 25%
        
        // when
        theViewController.perform(Selector(("scrubEnded")))
        
        // then
        guard case let .seek(t)? = fake.lastAction else {
            return XCTFail("Expected last action .seek")
        }
        XCTAssertEqual(t, 30, accuracy: 0.001) // 25% of 120 = 30s
        XCTAssertEqual(fake.currentTime, 30, accuracy: 0.001)
    }
    
    func test_delegate_loadDuration_updatesUI() {
        // given
        theViewController = makeViewController(fake: fake)
        
        // when
        fake.delegate?.mediaPlayerDidLoadDuration(90)
        
        // then
        let c = controls(theViewController)
        XCTAssertEqual(c.slider.value, 0)
        XCTAssertTrue(c.timeLabel.text?.contains("1:30") == true)
    }
    
    func test_delegate_updateProgress_movesSlider() {
        // given
        fake.duration = 100
        theViewController = makeViewController(fake: fake)
        
        // when
        fake.delegate?.mediaDidUpdateProgress(40)
        
        // then
        let c = controls(theViewController)
        XCTAssertEqual(c.slider.value, 0.4, accuracy: 0.001)
        XCTAssertTrue(c.timeLabel.text?.contains("0:40") == true)
    }
}
