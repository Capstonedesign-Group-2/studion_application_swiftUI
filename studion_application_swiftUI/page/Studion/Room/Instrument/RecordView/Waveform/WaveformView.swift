//
//  WaveformView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/05/04.
//

import SwiftUI
import UIKit
import AVFoundation

struct WaveformView: UIViewRepresentable {
    let url: URL
    
    @State var waveformView: VIWaveformView!
    
    func makeUIView(context: Context) -> UIView {
        setupWaveformView()
        
//        waveformView.translatesAutoresizingMaskIntoConstraints = false
//        waveformView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
//        waveformView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
//        waveformView.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
//        waveformView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        waveformView.layoutIfNeeded()
        
        let asset = AVAsset.init(url: url)
        _ = waveformView.loadVoice(from: asset, completion: { (asset) in
        })
        
        
        
        
        return waveformView
        
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    typealias UIViewType = UIView
    
    
    func setupWaveformView() {
        waveformView = VIWaveformView()
//        waveformView.backgroundColor = UIColor(red:0.10, green:0.14, blue:0.29, alpha:1.00)
        waveformView.minWidth = UIScreen.main.bounds.width
        
        waveformView.waveformNodeViewProvider = BasicWaveFormNodeProvider(generator: { () -> NodePresentation in
            let view = VIWaveformNodeView()
            view.waveformLayer.strokeColor = UIColor(red:0.86, green:0.35, blue:0.62, alpha:1.00).cgColor
            
            print(type(of: view))
            return view
        }())
        
        
        
        
    }
    
}
