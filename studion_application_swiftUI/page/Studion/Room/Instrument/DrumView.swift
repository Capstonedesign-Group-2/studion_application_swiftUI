//
//  DrumView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import SwiftUI
import WebRTC
import Combine
import AudioKit
import AVFoundation

struct DrumView: View {
    @StateObject var conductor = DrumsController()
    
    var dcDic: [String: Any]?
    
    let instrumentController = InstrumentController()
    
    let items = ["Q", "W", "E", "A", "S", "D", "Z", "X", "C"]
    let layout = [
        GridItem(.adaptive(minimum: 9, maximum: 9))
    ]
    
    var body: some View {
        VStack (spacing: 20){
//            Spacer()
//                .frame(height: 20)
            HStack (spacing: 20){
                
                Button(action: {
                    print("Q")
                    self.buttonClick(key: "Q")
                    self.conductor.playPad(padNumber: 0)
                }) {
                    Image("ride")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
                Button(action: {
                    print("W")
                    self.buttonClick(key: "W")
                    self.conductor.playPad(padNumber: 1)
                }) {
                    Image("hi-hat")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                    
                }
                
                Button(action: {
                    print("E")
                    self.buttonClick(key: "E")
                    self.conductor.playPad(padNumber: 2)
                }) {
                    Image("snap")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
            } // HStack
            
            HStack (spacing: 20){
                
                Button(action: {
                    print("A")
                    self.buttonClick(key: "A")
                    self.conductor.playPad(padNumber: 3)
                }) {
                    Image("tom")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
                Button(action: {
                    print("S")
                    self.buttonClick(key: "S")
                    self.conductor.playPad(padNumber: 4)
                }) {
                    Image("tom")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
                Button(action: {
                    print("D")
                    self.buttonClick(key: "D")
                    self.conductor.playPad(padNumber: 5)
                }) {
                    Image("tom")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                

            } // HStack
            
            HStack (spacing: 20){
                
                Button(action: {
                    print("Z")
                    self.buttonClick(key: "Z")
                    self.conductor.playPad(padNumber: 6)
                }) {
                    Image("snap")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
                Button(action: {
                    print("X")
                    self.buttonClick(key: "X")
                    self.conductor.playPad(padNumber: 7)
                }) {
                    Image("bass-drum")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
                Button(action: {
                    print("C")
                    self.buttonClick(key: "C")
                    self.conductor.playPad(padNumber: 8)
                }) {
                    Image("snap")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
            } // HStack
            
            Spacer()
            
        } // Vstack
        .onAppear{ self.conductor.start() }
        .onDisappear{ self.conductor.stop() }
        
    }
    
    func buttonClick(key: String) {
        
        
        let data: [String: String] = [
            "type" : "drum",
            "key" : key,
            "socketId" : SocketIO.sharedInstance.getSocketIOId()
        ]
        
        let encorder = JSONEncoder()
        do {
            let jsonData = try? encorder.encode(data)
            
            for key in self.dcDic!.keys {
                let dataChannel: RTCDataChannel = self.dcDic![key] as! RTCDataChannel
                let buffer = RTCDataBuffer(data: jsonData!, isBinary: true)
                
                dataChannel.sendData(buffer)
                print("send data channel")
            }
        } catch {
            print("error")
        }
        
//        instrumentController.drumController_my(key: key)
        
        
    }
}

class DrumsController: ObservableObject{
    @Published private(set) var lastPlayed: String = "None"
//    static let sharedInstance = DrumsController()
    let engine = AudioEngine()

    let drumSamples: [DrumSample] =
        [
            DrumSample("OPEN HI HAT", file: "cr.wav", note: 50),
            DrumSample("HI TOM", file: "hi.wav", note: 51),
            DrumSample("MID TOM", file: "rS.wav", note: 52),
            DrumSample("LO TOM", file: "tom3.wav", note: 53),
            DrumSample("HI HAT", file: "tom2.wav", note: 54),
            DrumSample("CLAP", file: "tom1.wav", note: 55),
            DrumSample("SNARE", file: "snst.wav", note: 49),
            DrumSample("KICK", file: "ki.wav", note: 48),
            DrumSample("KICK", file: "sn.wav", note: 47)
        ]

    let drums = AppleSampler()

    func playPad(padNumber: Int) {
        print("asdfasdf")
        drums.play(noteNumber: MIDINoteNumber(drumSamples[padNumber].midiNote))
        let fileName = drumSamples[padNumber].fileName
        lastPlayed = fileName.components(separatedBy: "/").last!
    }

    func start() {
        print("drum start")
        
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

        } catch {
            Log("Files Didn't Load")
        }
    }

    func stop() {
        engine.stop()
    }
    
}


struct DrumSample {
    var name: String
    var fileName: String
    var midiNote: Int
    var audioFile: AVAudioFile?

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
