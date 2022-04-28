//
//  RecordController.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/06.
//

import Foundation
import ReplayKit
import AudioKit

class RecordController {
    var player: AVAudioPlayer?
    
    func startRecording(enableMicorphone: Bool = false, completion: @escaping (Error?) -> ()) {
        let recorder = RPScreenRecorder.shared()


        recorder.isMicrophoneEnabled = false

        recorder.startRecording(handler: completion)
    }

    func stopRecording() async throws -> URL {
        let name = UUID().uuidString + ".wav"
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(name)

        let recorder = RPScreenRecorder.shared()

        try await recorder.stopRecording(withOutput: url)

        return url
    }
    
    func play(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            print(player?.duration)
            player?.play()
            print("play")
        } catch {
            print(error.localizedDescription)
        }
    
    }
    
    
}
