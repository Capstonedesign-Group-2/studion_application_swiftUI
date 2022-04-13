//
//  WebRTCDictionaryController.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/13.
//

import Foundation
import WebRTC

class WebRTCDictionaryController {
    static let sharedInstance = WebRTCDictionaryController()
    
    var pcDic: [String: RTCPeerConnection] = [:]
    var dcDic: [String: RTCDataChannel] = [:]
    var nameDic: [String: String] = [:]
    var userArray: [String] = []
    var hennkou: Bool = false
    
    
}
