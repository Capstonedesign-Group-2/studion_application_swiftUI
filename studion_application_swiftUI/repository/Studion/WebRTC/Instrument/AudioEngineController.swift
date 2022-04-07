//
//  AudioEngineController.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/07.
//

import Foundation
import AVFoundation

class AudioEngineController {
    static let sharedInstance = AudioEngineController()
    
    var audioEngine = AVAudioEngine()
    let mainMixer: AVAudioMixerNode
    
    init() {
        self.mainMixer = audioEngine.mainMixerNode
    }
    
    func play(audioFile: AVAudioFile, socketID: String, format: AVAudioFormat) {
        
        let node = AVAudioPlayerNode()
        
        let volume = VolumeController.sharedInstance.getVolume(socketID: socketID)
        
        node.volume = Float(20 * volume.volume * volume.masterVolume)
        
        do {
            self.audioEngine.attach(node)
            self.audioEngine.connect(node, to: self.mainMixer, format: format)
            
            if(audioEngine.isRunning == false) {
                try audioEngine.start()
                print("audioEngine start")
            }
            
            node.play()
            node.scheduleFile(audioFile, at: nil,completionHandler: nil)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
