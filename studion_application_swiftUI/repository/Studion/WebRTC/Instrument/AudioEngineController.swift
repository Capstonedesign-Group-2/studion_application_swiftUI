//
//  AudioEngineController.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/07.
//

import Foundation
import AVFoundation
import AudioKit
import ReplayKit

class AudioEngineController{
    static let sharedInstance = AudioEngineController()
    
    let engine = AudioEngine()
    let mixer = Mixer()
    let engine2 = AVAudioEngine()
    
//  ********************************************************************************
//  drum settings
//  ********************************************************************************
    var drumsKey = ["Q", "W", "E", "A", "S", "D", "Z", "X", "C"]
    var drums: [String: MIDISampler] = [:]
    var drumsSamples: [String: DrumSample] = [:]
    
    
//  ********************************************************************************
//  piano settings
//  ********************************************************************************
    var pianoKey = ["p_48", "p_49", "p_50", "p_51", "p_52", "p_53", "p_54", "p_55", "p_56", "p_57", "p_58", "p_59", "p_60", "p_61", "p_62", "p_63", "p_64", "p_65"]
    var piano: [String: MIDISampler] = [:]
    var pianoSamples: [String: PianoSample] = [:]
    
//  ********************************************************************************
//  record
//  ********************************************************************************
    var player: AVAudioPlayer?
    var playerNumber = -1
    
    
    
    func settings() {
        
        
//        drum init
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
        
//        piano init
        
        for key in pianoKey {
            piano[key] = MIDISampler(name: key)
            mixer.addInput(piano[key]!)
        }
        
        pianoSamples["p_48"] = PianoSample("p_48", file: "piano-ff-040", note: 60)
        pianoSamples["p_49"] = PianoSample("p_49", file: "piano-ff-041", note: 60)
        pianoSamples["p_50"] = PianoSample("p_50", file: "piano-ff-042", note: 60)
        pianoSamples["p_51"] = PianoSample("p_51", file: "piano-ff-043", note: 60)
        pianoSamples["p_52"] = PianoSample("p_52", file: "piano-ff-044", note: 60)
        pianoSamples["p_53"] = PianoSample("p_53", file: "piano-ff-045", note: 60)
        pianoSamples["p_54"] = PianoSample("p_54", file: "piano-ff-046", note: 60)
        pianoSamples["p_55"] = PianoSample("p_55", file: "piano-ff-047", note: 60)
        pianoSamples["p_56"] = PianoSample("p_56", file: "piano-ff-048", note: 60)
        pianoSamples["p_57"] = PianoSample("p_57", file: "piano-ff-049", note: 60)
        pianoSamples["p_58"] = PianoSample("p_58", file: "piano-ff-050", note: 60)
        pianoSamples["p_59"] = PianoSample("p_59", file: "piano-ff-051", note: 60)
        pianoSamples["p_60"] = PianoSample("p_60", file: "piano-ff-052", note: 60)
        pianoSamples["p_61"] = PianoSample("p_61", file: "piano-ff-053", note: 60)
        pianoSamples["p_62"] = PianoSample("p_62", file: "piano-ff-054", note: 60)
        pianoSamples["p_63"] = PianoSample("p_63", file: "piano-ff-055", note: 60)
        pianoSamples["p_64"] = PianoSample("p_64", file: "piano-ff-056", note: 60)
        pianoSamples["p_65"] = PianoSample("p_65", file: "piano-ff-057", note: 60)
        
        for key in pianoKey {
            do {
                try piano[key]!.loadAudioFiles([pianoSamples[key]!.audioFile!])
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
        
        
        
    }
    
    func drumsPlay(socketID: String, key: String, velocity: Float = 1.0) {
        if !engine.avEngine.isRunning {
            settings()
        }
        let volume = VolumeController.sharedInstance.getVolume(socketID: socketID)
        mixer.volume = Float(20 * volume.volume * volume.masterVolume)
        
        
        switch key {
        case "Q":
            drums[key]!.play(noteNumber: MIDINoteNumber(drumsSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "W":
            drums[key]!.play(noteNumber: MIDINoteNumber(drumsSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "E":
            drums[key]!.play(noteNumber: MIDINoteNumber(drumsSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "A":
            drums[key]!.play(noteNumber: MIDINoteNumber(drumsSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "S":
            drums[key]!.play(noteNumber: MIDINoteNumber(drumsSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "D":
            drums[key]!.play(noteNumber: MIDINoteNumber(drumsSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "Z":
            drums[key]!.play(noteNumber: MIDINoteNumber(drumsSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "X":
            drums[key]!.play(noteNumber: MIDINoteNumber(drumsSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "C":
            drums[key]!.play(noteNumber: MIDINoteNumber(drumsSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        default:
            return
        }
    }
    
    func pianoPlay(socketID: String, key: String, velocity: Float = 1.0) {
        if !engine.avEngine.isRunning {
            settings()
        }
        let volume = VolumeController.sharedInstance.getVolume(socketID: socketID)
        mixer.volume = Float(20 * volume.volume * volume.masterVolume)
        
        switch key {
        case "p_48":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_49":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_50":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_51":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_52":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_53":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_54":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_55":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_56":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_57":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_58":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_59":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_60":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_61":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_62":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_63":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_64":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
        case "p_65":
            piano[key]!.play(noteNumber: MIDINoteNumber(pianoSamples[key]!.midiNote), velocity: MIDIVelocity(velocity * 127.0), channel: 0)
            
        default:
            return
        }
    }
    
    func startRecord(completion: @escaping (Error?) -> ()) {
        let recorder = RPScreenRecorder.shared()
        
        recorder.isMicrophoneEnabled = false
        
        recorder.startRecording(handler: completion)
        
    }
    
    func stopRecord() async throws -> URL {
        let name = UUID().uuidString + ".wav"
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(name)
        
        let recorder = RPScreenRecorder.shared()
        
        try await recorder.stopRecording(withOutput: url)
        
        return url
    }
    
    func recordingPlayer(url: URL) {
        do {
            
            player = try AVAudioPlayer(contentsOf: url)
            player!.play()
            
        } catch {
            print(error.localizedDescription)
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

struct PianoSample {
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
