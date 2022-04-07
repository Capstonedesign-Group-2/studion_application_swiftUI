//
//  DrumController_test.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/07.
//

import Foundation
import AVFoundation

class DrumController_test {
    
    var audioEngine = AVAudioEngine()
    
    
    func start(key: String) {
        
        do {
            var audioPlayer = AVAudioPlayerNode()
            
            let fileURL = Bundle.main.url(forResource: key, withExtension: "wav")!
//            let audioFile = try AVAudioFile(forReading: fileURL)
//
//            let audioFormat = audioFile.processingFormat
//            let audioFrameCount = UInt32(audioFile.length)
//            let audioFileBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: audioFrameCount)
//
//            try audioFile.read(into: audioFileBuffer!)
//
//            let mainMixer = audioEngine.mainMixerNode
//            audioEngine.attach(audioPlayer)
//            audioEngine.connect(audioPlayer, to: mainMixer, format: audioFileBuffer?.format)
//
//            try audioEngine.start()
//
//            audioPlayer.play()
//
//            audioPlayer.scheduleBuffer(audioFileBuffer!, completionHandler: nil)
            
            let audioFile = try AVAudioFile(forReading: fileURL)
            
            let mainMixer = audioEngine.mainMixerNode
            audioEngine.attach(audioPlayer)
            audioEngine.connect(audioPlayer, to: mainMixer, format: audioFile.processingFormat)
            
            try audioEngine.start()
            
            audioPlayer.play()
            audioPlayer.scheduleFile(audioFile, at: nil,completionHandler: nil)
            
            
            
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
