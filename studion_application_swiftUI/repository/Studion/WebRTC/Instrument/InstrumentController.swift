//
//  InstrumentController.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import Foundation
import AVFoundation

class InstrumentController {
    
    
    
    var player: AVAudioPlayer?
    var drumKey: [String: Any] = [:]
//    var audioFiles: [AVAudioFile] = []
    
    init() {
        self.drumSettings()
    }
    
    func instrumentController(instrument: DataChannelCodableStruct.dataChannel) {
        
        switch instrument.type {
        case "drum":
            drumController(key: instrument.key, socketId: instrument.socketId)
//            let drumsController = DrumsController()
//            drumsController.drumPlay(key: instrument.key, socketId: instrument.socketId, handler: { data in
//            })
        default:
            print("other instrument")
        }
    }
    
    func drumController(key: String, socketId: String) {
        do {
            switch key {
            case "Q":
                print("Q")
                try player = AVAudioPlayer(contentsOf: drumKey[key] as! URL)
                player!.play()
                break
            case "W":
                print("W")
                try player = AVAudioPlayer(contentsOf: drumKey[key] as! URL)
                player!.play()
                break
            case "E":
                print("E")
                try player = AVAudioPlayer(contentsOf: drumKey[key] as! URL)
                player!.play()
                break
            case "A":
                print("A")
                try player = AVAudioPlayer(contentsOf: drumKey[key] as! URL)
                player!.play()
                break
            case "S":
                print("S")
                try player = AVAudioPlayer(contentsOf: drumKey[key] as! URL)
                player!.play()
                break
            case "D":
                print("D")
                try player = AVAudioPlayer(contentsOf: drumKey[key] as! URL)
                player!.play()
                break
            case "Z":
                print("Z")
                try player = AVAudioPlayer(contentsOf: drumKey[key] as! URL)
                player!.play()
                break
            case "X":
                print("X")
                try player = AVAudioPlayer(contentsOf: drumKey[key] as! URL)
                player!.play()
                break
            case "C":
                print("C")
                try player = AVAudioPlayer(contentsOf: drumKey[key] as! URL)
                player!.play()
                break

            default:
                print("other key")
                break
            }
        } catch {
            print("drum error")
        }



    }

//    func drumController_my(key: String) {
//        do {
//            switch key {
//            case "Q":
//                DrumsController.sharedInstance.playPad(padNumber: 0)
//                break
//            case "W":
//                DrumsController.sharedInstance.playPad(padNumber: 1)
//                break
//            case "E":
//                DrumsController.sharedInstance.playPad(padNumber: 2)
//                break
//            case "A":
//                DrumsController.sharedInstance.playPad(padNumber: 3)
//                break
//            case "S":
//                DrumsController.sharedInstance.playPad(padNumber: 4)
//                break
//            case "D":
//                DrumsController.sharedInstance.playPad(padNumber: 5)
//                break
//            case "Z":
//                DrumsController.sharedInstance.playPad(padNumber: 6)
//                break
//            case "X":
//                DrumsController.sharedInstance.playPad(padNumber: 7)
//                break
//            case "C":
//                DrumsController.sharedInstance.playPad(padNumber: 8)
//                break
//
//
//            default:
//                print("other key")
//                break
//            }
//        } catch {
//            print("drum error")
//        }
//
////        player!.play()
//
//    }

    func drumSettings() {

        var url = Bundle.main.url(forResource: "cr", withExtension: "wav")!
        drumKey["Q"] = url

        url = Bundle.main.url(forResource: "hi", withExtension: "wav")!
        drumKey["W"] = url

        url = Bundle.main.url(forResource: "rS", withExtension: "wav")!
        drumKey["E"] = url

        url = Bundle.main.url(forResource: "tom3", withExtension: "wav")!
        drumKey["A"] = url

        url = Bundle.main.url(forResource: "tom2", withExtension: "wav")!
        drumKey["S"] = url

        url = Bundle.main.url(forResource: "tom1", withExtension: "wav")!
        drumKey["D"] = url

        url = Bundle.main.url(forResource: "snst", withExtension: "wav")!
        drumKey["Z"] = url

        url = Bundle.main.url(forResource: "ki", withExtension: "wav")!
        drumKey["X"] = url

        url = Bundle.main.url(forResource: "sn", withExtension: "wav")!
        drumKey["C"] = url




    }
    
        
}
