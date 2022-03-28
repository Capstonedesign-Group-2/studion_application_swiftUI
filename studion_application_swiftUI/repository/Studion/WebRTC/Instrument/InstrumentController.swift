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
        print("test")
        switch instrument.type {
        case "drum":
           let drumsController_other = DrumsController_other()
            drumsController_other.setting(key: instrument.key, socketId: instrument.socketId)
            drumsController_other.playOrPause()

        default:
            print("other instrument")
        }
    }
    
    



    
        
}
