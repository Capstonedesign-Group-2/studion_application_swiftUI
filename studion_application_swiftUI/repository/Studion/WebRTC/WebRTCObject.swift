//
//  WebRTCObject.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/23.
//

import Foundation
import WebRTC
import SocketIO

protocol WebRTCObjectDelegate: AnyObject {
  func webRTCObject(_ client: WebRTCObject, didDiscoverLocalCandidate candidate: RTCIceCandidate)
  func webRTCObject(_ client: WebRTCObject, didChangeConnectionState state: RTCIceConnectionState)
  func webRTCObject(_ client: WebRTCObject, didReceiveData data: Data)
}


class WebRTCObject:NSObject {
    
    private static let factory: RTCPeerConnectionFactory = {
      RTCInitializeSSL()
      let videoEncoderFactory = RTCDefaultVideoEncoderFactory()
      let videoDecoderFactory = RTCDefaultVideoDecoderFactory()
      return RTCPeerConnectionFactory(encoderFactory: videoEncoderFactory, decoderFactory: videoDecoderFactory)
    }()
    
    weak var delegate: WebRTCClientDelegate?
    private let peerConnection: RTCPeerConnection
    private let rtcAudioSession =  RTCAudioSession.sharedInstance()
    private let audioQueue = DispatchQueue(label: "audio")
    private let mediaConstrains = [kRTCMediaConstraintsOfferToReceiveAudio: kRTCMediaConstraintsValueTrue,
                                   kRTCMediaConstraintsOfferToReceiveVideo: kRTCMediaConstraintsValueTrue]
    private var videoCapturer: RTCVideoCapturer?
    private var localVideoTrack: RTCVideoTrack?
    private var remoteVideoTrack: RTCVideoTrack?
    private var localDataChannel: RTCDataChannel?
    private var remoteDataChannel: RTCDataChannel?
    
    
    let socket:SocketIOClient = SocketIO.sharedInstance.getSocket()
    
    
    
    
    
    func createPeerConnection(name: String, socketID: String) {
        
        let iceServers:[RTCIceServer]
        iceServers = [RTCIceServer.init( urlStrings: ["stun:stun.l.google.com:19302"])]
        
        let config = RTCConfiguration()
        config.iceServers = iceServers
        config.sdpSemantics = .unifiedPlan
        
        // gatherContinually will let WebRTC to listen to any network changes and send any new candidates to the other client
        config.continualGatheringPolicy = .gatherContinually
        
        let constraints = RTCMediaConstraints(
          mandatoryConstraints: nil,
          optionalConstraints: ["DtlsSrtpKeyAgreement": kRTCMediaConstraintsValueTrue])
        
        var peerConnection: RTCPeerConnection
        
        peerConnection = WebRTCObject.factory.peerConnection(with: config, constraints: constraints, delegate: self)
        
        
        
        
        
//        self.createMediaSenders(peerConnection: peerConnection, name: name, socketID: socketID)
//        self.configureAudioSession()
//        print("createPeerConnection end \(peerConnection)")
//        
//        self.offer(peerConnection: peerConnection, name: name, socketID: socketID) { data in
//            print("offer end")
//        }
                
    }
    
}



extension WebRTCObject: RTCPeerConnectionDelegate {
  
  func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
//    debugPrint("peerConnection new signaling state: \(stateChanged)")
  }
  
  func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
//    debugPrint("peerConnection did add stream")
  }
  
  func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
//    debugPrint("peerConnection did remove stream")
  }
  
  func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
//    debugPrint("peerConnection should negotiate")
  }
  
  func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
    debugPrint("peerConnection new connection state: \(newState)")
    self.delegate?.webRTCClient(self, didChangeConnectionState: newState)
  }
  
  func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
//    debugPrint("peerConnection new gathering state: \(newState)")
  }
  
    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
      print("peerConnection candidate ??11")
//      print(candidate)
      let sendCandidate: [String: Any] = [
        "candidate" : candidate.sdp,
        "sdpMid" : candidate.sdpMid,
        "sdpMLineIndex" : candidate.sdpMLineIndex
      ]
      
      
        
        for key in self.pcDic.keys {
            let data: [String: Any] = [
              "candidate" : sendCandidate,
              "candidateSendID" : socket.sid,
              "candidateReceiveID" : key
            ]
//            print("key : \(key)")
            self.socket.emit("candidate", data)
        }

//      print("send")
      
      
    self.delegate?.webRTCClient(self, didDiscoverLocalCandidate: candidate)
  }
  
  func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
//    debugPrint("peerConnection did remove candidate(s)")
  }
  
  func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
    debugPrint("peerConnection did open data channel")
    self.remoteDataChannel = dataChannel
      
  }
}

extension WebRTCObject: RTCDataChannelDelegate {
  func dataChannelDidChangeState(_ dataChannel: RTCDataChannel) {
//    debugPrint("dataChannel did change state: \(dataChannel.readyState)")
  }
  
  func dataChannel(_ dataChannel: RTCDataChannel, didReceiveMessageWith buffer: RTCDataBuffer) {
      
      print("data channel ?? : \(buffer.data)")
      let decoder = JSONDecoder()
      
      do {
//          let json = try decoder.decode(Drum.key.self, from: buffer.data)
//          print(json)
      } catch {
          print("error")
      }
      
      print("눌림!")
      self.delegate?.webRTCClient(self, didReceiveData: buffer.data)
  }
    
}
