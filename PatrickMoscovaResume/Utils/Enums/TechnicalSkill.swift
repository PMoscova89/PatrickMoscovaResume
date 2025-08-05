//
//  TechnicalSkill.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/3/25.
//
enum TechnicalSkill: String, CaseIterable {
    case alamofire = "Alamofire"
    case autoLayout = "Auto Layout"
    case avFoundation = "AVFoundation"
    case carthageCharts = "Carthage + iOS Charts"
    case coreAnimation = "Core Animation"
    case coreBluetooth = "Core Bluetooth"
    case coreData = "Core Data"
    case coreLocation = "Core Location"
    case darkMode = "Dark Mode"
    case deepLinking = "Deep Linking"
    case gcd = "GCD (Swift & Objective-C)"
    case localization = "Localization (Haitian Kreyol)"
    case mapKit = "MapKit"
    case nsOperationQueue = "NSOperationQueue"
    case openGL = "OpenGL"
    case pushKit = "PushKit"
    case quartzCore = "QuartzCore"
    case rxSwift = "RXSwift"
    case swiftConcurrency = "Swift Concurrency"
    case swiftUI = "SwiftUI"
    
    var iconName: String? {
        switch self {
            case .alamofire: return "bolt.fill"
            case .autoLayout: return "rectangle.3.offgrid"
            case .avFoundation: return "play.rectangle.fill"
            case .carthageCharts: return "chart.bar.fill"
            case .coreAnimation: return "sparkles"
            case .coreBluetooth: return "wave.3.right"
            case .coreData: return "externaldrive.fill"
            case .coreLocation: return "location.fill"
            case .darkMode: return "moon.fill"
            case .deepLinking: return "link"
            case .gcd: return "flowchart"
            case .localization: return "globe"
            case .mapKit: return "map.fill"
            case .nsOperationQueue: return "lines.measurement.horizontal"
            case .openGL: return "circle.hexagongrid.fill"
            case .pushKit: return "bell.badge.fill"
            case .quartzCore: return "circle.grid.cross"
            case .rxSwift: return "arrow.triangle.2.circlepath"
            case .swiftConcurrency: return "clock.arrow.2.circlepath"
            case .swiftUI: return "swift"
        }
    }
}

