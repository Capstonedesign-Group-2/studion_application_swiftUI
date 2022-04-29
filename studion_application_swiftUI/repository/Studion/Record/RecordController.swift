//
//  RecordController.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/06.
//

import Foundation
import AVFoundation

class RecordController {
    var player: AVAudioPlayer?
    
    func play(url: URL) {
        do {
            
            player = try AVAudioPlayer(contentsOf: url)
            player!.play()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
