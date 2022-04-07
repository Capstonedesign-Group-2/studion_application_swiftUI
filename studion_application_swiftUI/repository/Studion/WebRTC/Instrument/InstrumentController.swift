//
//  InstrumentController.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import Foundation
import AVFoundation

class InstrumentController {
    
    let drumsController = DrumsController()
    
    func instrumentController(instrument: DataChannelCodableStruct.dataChannel) {
        
        print(instrument.type)
        switch instrument.type {
        case "drum":
            self.drumsController.settings_other(key: instrument.key, socketID: instrument.socketId)
            
        case "onPiano" :
            let pianoController_other = PianoController_other()
            pianoController_other.setting(key: instrument.key, socketId: instrument.socketId)
            pianoController_other.playOrPause()

        default:
            print("other instrument")
        }
    }
    
    



    
        
}
