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
    var dcDic: [String: Any]
    
    var body: some View {
        
        VStack {
            Button("peerConnection") {
                for key in pcDic.keys {
                    let peerConnection = pcDic[key] as! RTCPeerConnection
                    print(key)
                    switch peerConnection.connectionState {
                    case .connected:
                        print("connected")
                    case .connecting:
                        print("connecting")
                    case .disconnected:
                        print("disconnected")
                    case .failed:
                        print("failed")
                    case .new:
                        print("new")
                        
                    default:
                        print("?")
                    }
                    
                }
            }
            
            Button("datachannel") {
                for key in dcDic.keys {
                    let dataChannel = dcDic[key] as! RTCDataChannel
                    print(key)
                    switch dataChannel.readyState {
                    case .open:
                        print("open")
                    case .connecting:
                        print("connecting")
                    case .closing:
                        print("closing")
                    case .closed:
                        print("closed")
                    default:
                        print("?")
                    }
                    
                }
            }
        }
        
            .onAppear{
                print("piano start")
            }
            .onDisappear{
                print("piano end")
            }
    }
}


