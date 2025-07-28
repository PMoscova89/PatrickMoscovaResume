//
//  ResumeUIKitViewController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/26/25.
//

import UIKit
import PDFKit

class ResumeUIKitViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .myBackground
        if let pdfView = createAndSetupPDFView() {
            view.addSubview(pdfView)
        }
    }
}

extension ResumeUIKitViewController {
    fileprivate func createAndSetupPDFView() -> PDFView? {
        let pdfView = PDFView(frame: view.bounds)
        pdfView.autoScales = true
        
        if let url = Bundle.main.url(forResource: "resume", withExtension: "pdf") {
            if let document = PDFDocument(url: url) {
                pdfView.document = document
                return pdfView
            }
        }
        return nil
    }
}
