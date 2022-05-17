//
//  RecordController.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/06.
//

import Foundation
import AVFoundation
import SwiftUI

class RecordController {
    static let sharedInstance = RecordController()
    
    
    var url: URL?
    
    func setUrl(url: URL) {
        self.url = url
    }
    
    func getUrl() -> URL {
        return self.url!
    }
    
}

struct ShareSheet: UIViewControllerRepresentable {
    
    
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let view = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
