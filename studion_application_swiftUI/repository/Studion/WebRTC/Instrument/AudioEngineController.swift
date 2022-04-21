//
//  AudioEngineController.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/07.
//

import Foundation
import AVFoundation
import AudioKit

class AudioEngineController{
    static let sharedInstance = AudioEngineController()
    
    let engine = AudioEngine()
    let mixer = Mixer()
    let engine2 = AVAudioEngine()
    
    let test = AVAudioUnitSampler()
    
    
    var drumsKey = ["Q", "W", "E", "A", "S", "D", "Z", "X", "C"]
    var drums: [String: MIDISampler] = [:]
    var drumsSamples: [String: DrumSample] = [:]
    
    func settings() {
        
        for key in drumsKey {
            drums[key] = MIDISampler(name: ("drum" + key))
            mixer.addInput(drums[key]!)
        }
        
        drumsSamples["Q"] = DrumSample("Q", file: "cr", note: 60)
        drumsSamples["W"] = DrumSample("W", file: "hi", note: 60)
        drumsSamples["E"] = DrumSample("E", file: "rS", note: 60)
        drumsSamples["A"] = DrumSample("A", file: "tom3", note: 60)
        drumsSamples["S"] = DrumSample("S", file: "tom2", note: 60)
        drumsSamples["D"] = DrumSample("D", file: "tom1", note: 60)
        drumsSamples["Z"] = DrumSample("Z", file: "snst", note: 60)
        drumsSamples["X"] = DrumSample("X", file: "ki", note: 60)
        drumsSamples["C"] = DrumSample("C", file: "sn", note: 60)
        
        for key in drumsKey {
            do {
                try drums[key]!.loadAudioFiles([drumsSamples[key]!.audioFile!])
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
        
        engine.output = mixer
        
        
        do {
            print("audiokit engine start")
            try engine.start()
        } catch {
            print(error.localizedDescription)
        }
        
        print("audioEngine setting")
    }
    
    func drumsPlay(socketID: String, key: String, velocity: Float = 1.0) {
        if !engine.avEngine.isRunning {
            settings()
        }
        
        
        switch key {
        case "Q":
            print("drumQ")
            
            print(AVAudioSession.sharedInstance().availableModes)
            print(AVAudioSession.sharedInstance().currentRoute)
//            do {
//                try AVAudioSession.sharedInstance().setInputGain(1)
//            } catch {
//                print(error.localizedDescription)
//            }
            
            drums[key]!.play(noteNumber: MIDINoteNumber(drumsSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
//            guard let url = Bundle.main.url(forResource: "cr", withExtension: "wav") else {
//                return
//            }
//            do {
//                try test.loadAudioFiles(at: [url])
//            } catch {
//                print(error.localizedDescription)
//            }
//
//            engine2.attach(test)
//            engine2.connect(test, to: engine2.outputNode, format: nil)
            
            
        
            
        default:
            return
        }
    }
    
}

struct DrumSample {
    var name: String
    var fileName: String
    var midiNote: Int
    var audioFile: AVAudioFile?
    
    init(_ displayName: String, file: String, note: Int) {
        name = displayName
        fileName = file
        midiNote = note
        
        guard let url = Bundle.main.url(forResource: file, withExtension: "wav") else {
            print("Could not find: \(file)")
            return
        }
        
        do {
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            print("Could not load: \(url)")
        }
    }
}
