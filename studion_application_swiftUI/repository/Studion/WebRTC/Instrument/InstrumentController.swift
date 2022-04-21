//
//  InstrumentController.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import Foundation
import AVFoundation

class InstrumentController {
    
    func instrumentController(instrument: DataChannelCodableStruct.dataChannel) {
        
        print(instrument.type)
        switch instrument.type {
        case "drum":
            print("AA")
            AudioEngineController.sharedInstance.drumsPlay(socketID: instrument.socketId, key: instrument.key)
            
        case "onPiano" :
            AudioEngineController.sharedInstance.pianoPlay(socketID: instrument.socketId, key: instrument.key)

        default:
            print("other instrument")
        }
    }
    
    



    
        
}
