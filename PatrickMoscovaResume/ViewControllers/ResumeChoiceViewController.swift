//
//  ResumeChoiceViewController.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/26/25.
//

import UIKit
import SwiftUI

class ResumeChoiceViewController: UIViewController {

    @IBOutlet weak var uiKitButton: IconTextButton!
    
    @IBOutlet weak var swiftUIButton: IconTextButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func uiKitButtonTapped(_ sender: Any) {
        let pdfViewController = ResumeUIKitViewController()
        present(pdfViewController, animated: true)
    }
    
    @IBAction func swiftUIButtonTapped(_ sender: Any) {
        let swiftUIView = ResumeSwiftUIView()
        let hostingViewController = UIHostingController(rootView: swiftUIView)
        present(hostingViewController, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ResumeChoiceViewController {
    func setupButtons() {
        uiKitButton.configure(imageName: Constants.ImageNames.swiftLogo,
                              title: Constants.Titles.swiftButtonTitle,
                              imageSize: Constants.imageSizeXLarge,
                              font: .systemFont(ofSize: Constants.fontSizeXXLarge))
        swiftUIButton.configure(imageName: Constants.ImageNames.swiftUILogo,
                                title: Constants.Titles.swiftUIButtonTitle,
                                imageSize: Constants.imageSizeXLarge,
                                font: .systemFont(ofSize: Constants.fontSizeXXLarge))
    }
}
