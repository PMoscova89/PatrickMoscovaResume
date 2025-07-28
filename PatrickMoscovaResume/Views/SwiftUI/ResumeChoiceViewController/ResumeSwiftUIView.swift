//
//  ResumeSwiftUIView.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 7/28/25.
//

import SwiftUI
import PDFKit

struct ResumeSwiftUIView :  View {
    let fileName: String = "resume"
    let title: String = "Patrick Moscova"
    var body: some View {
        NavigationView{
            if let url = Bundle.main.url(forResource: fileName, withExtension: "pdf") {
                PDFKitView(url: url)
                    .navigationTitle(title)
                    .navigationBarTitleDisplayMode(.inline)
            }else{
                Text("Could not find \(fileName). Is it a pdf? Is it in the correct location?. Do you have the correct file name?")
            }
        }
    }
    
}
