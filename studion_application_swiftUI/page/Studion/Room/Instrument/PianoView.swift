//
//  PianoView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import SwiftUI
import WebRTC

struct PianoView: View {
    var pcDic: [String: Any]
    
    var body: some View {
        Button("test") {
            print(pcDic.keys)
            for key in pcDic.keys {
                (pcDic[key] as! RTCPeerConnection).transceivers
                    .compactMap{ return $0.sender.track}
                    .forEach{ ($0 as! RTCAudioTrack).source.volume = 0
                        
                    }
            }
        }
    }
}


