//
//  PDFKitView.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/28/25.
//

import PDFKit
import SwiftUI

struct PDFKitView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.backgroundColor = .myBackground
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }
    func updateUIView(_ uiView: PDFView, context: Context) {
        
    }
}
