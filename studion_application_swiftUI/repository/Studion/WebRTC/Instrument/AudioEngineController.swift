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
    let mainMixer: AVAudioNode
    var audioFile: AVAudioFile?
    
    
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
    
    
    
    func record() {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error.localizedDescription)
        }
        
        
        let format = self.mainMixer.outputFormat(forBus: 0)
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//
        do {
//
            self.audioFile = try AVAudioFile(forWriting: documentURL.appendingPathComponent("record.wav"), settings: format.settings)
//
        } catch {
            print(error.localizedDescription)
        }
//
//        self.mainMixer.installTap(onBus: 0, bufferSize: 1024, format: format, block: { (buffer, time) in
//
//            try? self.audioFile?.write(from: buffer)
//        })
//
//        print("record start")
        
//        self.audioFile = AVAudioFile(forWriting: URLFor("my_file.caf")!, settings: audioEngine.inputNode.inputFormatForBus(0).settings, error: nil)
        
        
        print("----------------------------------------------------")
//        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { (buffer, time) in
//                try! self.audioFile?.write(from: buffer)
//                print(buffer)
//            print(self.audioFile)
//            }
             
        self.audioEngine.outputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { (buffer, time)  in
            try! self.audioFile?.write(from: buffer)
            print(buffer)
            print(self.audioFile)
        }
        
    }
    

    
    func stop() -> URL?{
//        self.mainMixer.removeTap(onBus: 0)
//        print("record end")
//        print(self.audioFile!.url)
//        return self.audioFile?.url
        audioEngine.inputNode.removeTap(onBus: 0)
        print("record end")
        print(self.audioFile!.url)
        return self.audioFile?.url
    }
    
}
