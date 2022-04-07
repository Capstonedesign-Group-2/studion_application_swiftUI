//import Foundation
//import AVFoundation
//
//class DrumsController {
//    
//    func settings(key: String, socketID: String) {
//        
//        
//        var fileURL: URL?
//        switch key {
//
//        case "Q" :
//            fileURL = Bundle.main.url(forResource: "cr", withExtension: "wav")
//            break
//        case "W":
//            fileURL = Bundle.main.url(forResource: "hi", withExtension: "wav")
//            break
//        case "E":
//            fileURL = Bundle.main.url(forResource: "rS", withExtension: "wav")
//            break
//        case "A":
//            fileURL = Bundle.main.url(forResource: "tom3", withExtension: "wav")
//            break
//        case "S":
//            fileURL = Bundle.main.url(forResource: "tom2", withExtension: "wav")
//            break
//        case "D":
//            fileURL = Bundle.main.url(forResource: "tom1", withExtension: "wav")
//            break
//        case "Z":
//            fileURL = Bundle.main.url(forResource: "snst", withExtension: "wav")
//            break
//        case "X":
//            fileURL = Bundle.main.url(forResource: "ki", withExtension: "wav")
//            break
//        case "C":
//            fileURL = Bundle.main.url(forResource: "sn", withExtension: "wav")
//            break
//
//        default:
//            fileURL = nil
//            return
//        }
//        
//        do {
//            let audioFile = try AVAudioFile(forReading: fileURL!)
//            
//            AudioEngineController.sharedInstance.play(audioFile: audioFile, socketID: socketID, format: audioFile.processingFormat)
//            
//        } catch {
//            print(error.localizedDescription)
//        }
//        
//        
//        
//    }
//}
