// Copyright AudioKit. All Rights Reserved.

import AudioKit
import AVFoundation
import Combine
import SwiftUI

struct DrumSample {
    var name: String
    var fileName: String
    var midiNote: Int
    var audioFile: AVAudioFile?
    var color = UIColor.red

    init(_ prettyName: String, file: String, note: Int) {
        name = prettyName
        fileName = file
        midiNote = note

        guard let url = Bundle.main.resourceURL?.appendingPathComponent(file) else { return }
        do {
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            Log("Could not load: $fileName")
        }
    }
}

class DrumsConductor: ObservableObject {
    // Mark Published so View updates label on changes
    @Published private(set) var lastPlayed: String = "None"

    let engine = AudioEngine()
    

    let drumSamples: [DrumSample] =
        [
            DrumSample("OPEN HI HAT", file: "cr.wav", note: 50),
            DrumSample("HI TOM", file: "cr.wav", note: 50),
            DrumSample("MID TOM", file: "cr.wav", note: 50),
            DrumSample("LO TOM", file: "cr.wav", note: 50),
            DrumSample("HI HAT", file: "cr.wav", note: 50),
            DrumSample("CLAP", file: "cr.wav", note: 50),
            DrumSample("SNARE", file: "cr.wav", note: 50),
            DrumSample("KICK", file: "cr.wav", note: 50)
        ]

    let drums = AppleSampler()

    func playPad(padNumber: Int) {
        
        print("-----------------------------")
        print(drumSamples[padNumber].midiNote)
        print("-----------------------------")
      
        drums.play(noteNumber: MIDINoteNumber(drumSamples[padNumber].midiNote))
    }

    func start() {
        
        engine.output = drums
        
        do {
            try engine.start()
            
            
            
        } catch {
            Log("AudioKit did not start! \(error)")
        }
        do {
            let files = drumSamples.map {
                $0.audioFile!
            }
            try drums.loadAudioFiles(files)

//            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: [.mixWithOthers])
//
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
            

        } catch {
            Log("Files Didn't Load")
        }
        
    }

    func stop() {
        engine.stop()
    }
    
}


