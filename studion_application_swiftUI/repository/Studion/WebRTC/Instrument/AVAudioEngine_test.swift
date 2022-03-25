//
//  AVAudioEngine.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import Foundation
import AVFoundation
import WebRTC

class AVAudioEngine_test:NSObject {
    
    func settings() {
        print("audio test")
        guard let fileURL = Bundle.main.url(forResource: "cr", withExtension: "wav") else {return}

        do {
            let file = try AVAudioFile(forReading: fileURL)
            let format = file.processingFormat

            
            let audioEngine = AVAudioEngine()
            let playerNode = AVAudioPlayerNode()
            
            audioEngine.attach(playerNode)
            audioEngine.connect(playerNode, to: audioEngine.outputNode, format: format)
            
            playerNode.scheduleFile(file, at: nil) {
                print("song end")
            }
            
            try audioEngine.start()
            
            playerNode.play()
            
            
        } catch {
            print("error audio engine")
        }


        

//        audioEngine.attach(playerNode)
        
        
//        let stream: RTCAudioTrack
        
        
        
    
        
    }
    
    func audiotracktest(audio: RTCAudioTrack) {
        
        
        print("---------------------------------")
        print(audio.source)
        print(audio.source.volume)
        audio.source.volume = -1.0
        print(audio.source.volume)
        print(audio.source.state)
        
        print("---------------------------------")
    }
}
