//
//  WebRTCController.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/23.
//

import Foundation
import WebRTC
import SocketIO
import IOSurface
import SceneKit
import AVFoundation

protocol WebRTCClientDelegate: AnyObject {
  func webRTCClient(_ client: WebRTCClient, didDiscoverLocalCandidate candidate: RTCIceCandidate)
  func webRTCClient(_ client: WebRTCClient, didChangeConnectionState state: RTCIceConnectionState)
  func webRTCClient(_ client: WebRTCClient, didReceiveData data: Data)
}

final class WebRTCClient: NSObject {
    

//    var pcDic: [String: RTCPeerConnection] = [:]
//    var dcDic: [String: RTCDataChannel] = [:]
//    var nameDic: [String: String] = [:]
//    var userArray: [String] = []

    private static let factory: RTCPeerConnectionFactory = {
      RTCInitializeSSL()
      let videoEncoderFactory = RTCDefaultVideoEncoderFactory()
      let videoDecoderFactory = RTCDefaultVideoDecoderFactory()
      return RTCPeerConnectionFactory(encoderFactory: videoEncoderFactory, decoderFactory: videoDecoderFactory)
    }()

    weak var delegate: WebRTCClientDelegate?
    private let rtcAudioSession =  RTCAudioSession.sharedInstance()
    private let audioQueue = DispatchQueue(label: "audio")
    private let mediaConstrains = [kRTCMediaConstraintsOfferToReceiveAudio: kRTCMediaConstraintsValueTrue,
                                   kRTCMediaConstraintsOfferToReceiveVideo: kRTCMediaConstraintsValueTrue]
    private var videoCapturer: RTCVideoCapturer?
    private var localVideoTrack: RTCVideoTrack?
    private var remoteVideoTrack: RTCVideoTrack?
    private var localDataChannel: RTCDataChannel?
    private var remoteDataChannel: RTCDataChannel?

//    private var name: String?
    private var socketID: String?
    let instrumentController = InstrumentController()
    

    let socket:SocketIOClient = SocketIO.sharedInstance.getSocket()

    
    func joinRoom(room: Int) {
        
            do {
                let userInfo = UserInfo()
                let user = UserInfo.userInfo.getUserInfo()!
                
                

                let userData : [String: Any] = [
                    "id" : user.id as Any,
                    "name" : user.name as Any,
                    "email" : user.email as Any,
                    "image" : user.image as Any,
                    "created_at" : user.created_at as Any,
                    "updated_at" : user.updated_at as Any,
                ]
                let data : [String: Any] = [
                    "room_id" : room,
                    "user" : userData,
                ]
                print("2222222222222222222222222222222222222222222222")
                socket.emit("join_room", data)
            } catch {
                print("user info error")
            }
            
        
        

    }

    func allUsers(handler: @escaping (Any) -> Void) {
        socket.on("all_users") {data, ack in
            print("[room] allUsers :\(VolumeController.sharedInstance.getEnterState())")
            if(VolumeController.sharedInstance.getEnterState() == false) {
                VolumeController.sharedInstance.setEnterState()
                let users: [Any] = data[0] as! [NSDictionary]
                print(users)

                for user in users {

                    print("for user in users")
                    let userDictionary = user as! Dictionary<String, Any>

                    let name = userDictionary["name"] as! String
                    let socketID = userDictionary["id"] as! String

                    self.socketID = socketID
                    let peerConnection = self.createPeerConnection(name: name, socketID: socketID, late: true) as! RTCPeerConnection
                    
                    let userInfo = UserInfo.userInfo.getUserInfo()
                    
                    self.offer(peerConnection: peerConnection, name: (userInfo?.name)!, socketID: socketID) { data in
                        print("offer end")
                        
                        let dic: [String: Any] = [
//                            "pcDic" : self.pcDic,
//                            "dcDic" : self.dcDic,
//    //                        "volumeDic" : self.volumeDic
//                            "userArray" : self.userArray,
//                            "nameDic" : self.nameDic,
                            "pcDic" : WebRTCDictionaryController.sharedInstance.pcDic,
                            "dcDic" : WebRTCDictionaryController.sharedInstance.dcDic,
    //                        "volumeDic" : self.volumeDic
                            "userArray" : WebRTCDictionaryController.sharedInstance.userArray,
                            "nameDic" : WebRTCDictionaryController.sharedInstance.nameDic
                        ]
                        
                        handler(dic)
                    }
                }
                
                
            }
            
            

        }
    }

    func createPeerConnection(name: String, socketID: String, late: Bool) -> RTCPeerConnection{

        print("createPeerConnection")
        let iceServers:[RTCIceServer]
        iceServers = [RTCIceServer.init( urlStrings: ["stun:stun.l.google.com:19302", "turn:35.77.186.121:3478"], username: "turn", credential: "dls980728")]
//        iceServers = [RTCIceServer.init( urlStrings: ["stun:stun.l.google.com:19302"])]

        let config = RTCConfiguration()
        config.iceServers = iceServers
        config.sdpSemantics = .unifiedPlan

        // gatherContinually will let WebRTC to listen to any network changes and send any new candidates to the other client
        config.continualGatheringPolicy = .gatherContinually

        let constraints = RTCMediaConstraints(
          mandatoryConstraints: nil,
          optionalConstraints: ["DtlsSrtpKeyAgreement": kRTCMediaConstraintsValueTrue])

        var peerConnection: RTCPeerConnection

        peerConnection = WebRTCClient.factory.peerConnection(with: config, constraints: constraints, delegate: self)

//        self.pcDic[socketID] = peerConnection
        WebRTCDictionaryController.sharedInstance.pcDic[socketID] = peerConnection
        
//        self.volumeDic[socketID] = UserVolumeStruct.volume(socketId: socketID, volume: 0.8, masterVolume: 0.8)
//        self.nameDic[socketID] = name
        WebRTCDictionaryController.sharedInstance.nameDic[socketID] = name
        
        VolumeController.sharedInstance.setVolumeDic(socketID: socketID)
//        if(userArray.contains(socketID) == false) {
//            userArray.append(socketID)
//        }
        
        if(WebRTCDictionaryController.sharedInstance.userArray.contains(socketID) == false) {
            WebRTCDictionaryController.sharedInstance.userArray.append(socketID)
        }

        self.createMediaSenders(peerConnection: peerConnection, name: name, socketID: socketID, late: late)
        self.configureAudioSession()
        print("createPeerConnection end \(peerConnection)")

        

        return peerConnection

    }

//  ************************************************************************************
//        세팅
//  ************************************************************************************


    func createMediaSenders(peerConnection: RTCPeerConnection, name: String, socketID: String, late: Bool) {
        
        print("createMediaSenders")
        let streamId = "stream"

        // Audio
        let audioTrack = self.createAudioTrack()
        
        peerConnection.add(audioTrack, streamIds: [streamId])
        
        
        // Data
        if (late == true) {
            if let dataChannel = createDataChannel(peerConnection: peerConnection, name: name, socketID: socketID) {
              dataChannel.delegate = self
    //          self.localDataChannel = dataChannel
            
                
            }
        }
        



//        print("createMediaSenders end")
    }

    func createDataChannel(peerConnection: RTCPeerConnection, name: String, socketID: String) -> RTCDataChannel?{
        
        // 나중에 들어갔을 때
        
        let config = RTCDataChannelConfiguration()
        
        guard let dataChannel = peerConnection.dataChannel(forLabel: socket.sid, configuration: config) else {
          debugPrint("Warning: Couldn't create data channel.")
          return nil
        }

//        self.dcDic[socketID] = dataChannel
        WebRTCDictionaryController.sharedInstance.dcDic[socketID] = dataChannel
        
//        print("***************************")
//        for key in dcDic.keys {
//
//            print(key)
//            print(dcDic[key]!.label)
//
//        }
//
//        print("***************************")
        return dataChannel
    }


    func createAudioTrack() -> RTCAudioTrack {
        let audioConstrains = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
        let audioSource = WebRTCClient.factory.audioSource(with: audioConstrains)
        let audioTrack = WebRTCClient.factory.audioTrack(with: audioSource, trackId: "audio0")
        return audioTrack
    }

    func configureAudioSession() {
        self.rtcAudioSession.lockForConfiguration()
        do {
            try self.rtcAudioSession.setCategory(AVAudioSession.Category.playAndRecord.rawValue)

        
        } catch let error {
          debugPrint("Error changeing AVAudioSession category: \(error)")
        }
        self.rtcAudioSession.unlockForConfiguration()

    }

//  ************************************************************************************
//    오퍼 만들기
//  ************************************************************************************
    func offer(peerConnection: RTCPeerConnection, name: String, socketID: String, completion: @escaping (_ sdp: RTCSessionDescription) -> Void) {
      let constrains = RTCMediaConstraints(
        mandatoryConstraints: self.mediaConstrains,
        optionalConstraints: nil)
      peerConnection.offer(for: constrains) { (sdp, error) in
        guard let sdp = sdp else {
          return
        }

        peerConnection.setLocalDescription(sdp, completionHandler: { (error) in


            let offerData: [String: Any] = [
                "type" : "offer",
                "sdp" : sdp.sdp
            ]

            let offer: [String: Any] = [
                "sdp" : offerData,
                "offerSendID" : self.socket.sid,
                "offerSendName" : name ,
                "offerReceiveID" : socketID
            ]

            print("sendOffer")
            self.socket.emit("offer", offer as! SocketData)

            completion(sdp)

        })
      }
    }

//  ************************************************************************************
//    엔서 받기
//  ************************************************************************************

    func getAnswer(handler: @escaping (Any) -> Void) {

        self.socket.on("getAnswer") { [self]data, ack in
            print("getAnswer")
            let answer = data[0] as! Dictionary<String, Any>
            let answerSDP = answer["sdp"] as! Dictionary<String, Any>

            let sdp: RTCSessionDescription = RTCSessionDescription(type: RTCSdpType.answer, sdp: answerSDP["sdp"] as! String)

//            print(answer["answerSendID"] as! String)
//            print(pcDic)
//            if(self.pcDic[answer["answerSendID"] as! String] != nil) {
//                let peerConnection = self.pcDic[answer["answerSendID"] as! String]! as RTCPeerConnection
                let peerConnection = WebRTCDictionaryController.sharedInstance.pcDic[answer["answerSendID"] as! String]! as RTCPeerConnection
    //
                peerConnection.setRemoteDescription(sdp) {data in
    //                print("daas")
                    
                    let dic: [String: Any] = [
//                        "pcDic" : self.pcDic,
//                        "dcDic" : self.dcDic,
//    //                    "volumeDic" : self.volumeDic
//                        "userArray" : self.userArray,
//                        "nameDic" : self.nameDic,
                        "pcDic" : WebRTCDictionaryController.sharedInstance.pcDic,
                        "dcDic" : WebRTCDictionaryController.sharedInstance.dcDic,
//                        "volumeDic" : self.volumeDic
                        "userArray" : WebRTCDictionaryController.sharedInstance.userArray,
                        "nameDic" : WebRTCDictionaryController.sharedInstance.nameDic
                    ]
                    
                    handler(dic)
                }
//            }
            
        }
    }

    func getOffer(handler: @escaping (Any) -> Void) {
        self.socket.on("getOffer") {data, ack in
            print("getOffer")
            let response = data[0] as! Dictionary<String, Any>
            let sdp = response["sdp"] as! Dictionary<String, Any>

//            self.nameDic[response["offerSendID"] as! String] = response["offerSendName"] as! String
            WebRTCDictionaryController.sharedInstance.nameDic[response["offerSendID"] as! String] = response["offerSendName"] as! String
            
            self.socketID = response["offerSendID"] as! String
//            self.createPeerConnection(name: response["offerSendName"] as! String, socketID: response["offerSendID"] as! String)

//            let peerConnection: RTCPeerConnection = self.pcDic[response["offerSendID"] as! String] as! RTCPeerConnection

            let peerConnection: RTCPeerConnection = self.createPeerConnection(name: response["offerSendName"] as! String, socketID: response["offerSendID"] as! String, late: false)
            print("core?")
            
            let createSdp: RTCSessionDescription = RTCSessionDescription(type: RTCSdpType.offer, sdp: sdp["sdp"] as! String)
            peerConnection.setRemoteDescription(createSdp) { data in

                self.sendAnswer(peerConnection: peerConnection, answerReceiveID: response["offerSendID"] as! String) {data in
                    print("end")
                    
                    let dic: [String: Any] = [
//                        "pcDic" : self.pcDic,
//                        "dcDic" : self.dcDic,
////                        "volumeDic" : self.volumeDic
//                        "userArray" : self.userArray,
//                        "nameDic" : self.nameDic,
                        "pcDic" : WebRTCDictionaryController.sharedInstance.pcDic,
                        "dcDic" : WebRTCDictionaryController.sharedInstance.dcDic,
//                        "volumeDic" : self.volumeDic
                        "userArray" : WebRTCDictionaryController.sharedInstance.userArray,
                        "nameDic" : WebRTCDictionaryController.sharedInstance.nameDic
                    ]
                    
                    handler(dic)
                }
            }

        }
    }

    func sendAnswer(peerConnection: RTCPeerConnection, answerReceiveID: String, handler: @escaping (Any) -> Void) {
        let constrains = RTCMediaConstraints(mandatoryConstraints: self.mediaConstrains,
                                             optionalConstraints: nil)


        peerConnection.answer(for: constrains){ (sdp, error) in
            guard let sdp = sdp else {
                return
            }

            peerConnection.setLocalDescription(sdp, completionHandler: { (error) in

                let sdpData: [String: String] = [
                    "type" : "answer",
                    "sdp" : sdp.sdp
                ]
                
                let data: [String: Any] = [
                    "sdp" : sdpData,
                    "answerSendID" : self.socket.sid,
                    "answerReceiveID" : answerReceiveID
                ]
                
                self.socket.emit("answer", data)
                
                
                handler(sdp)

            })
        }
    }


    func getCandidate(handler: @escaping (Any) -> Void) {
        socket.on("getCandidate") {data, ack in
            print("getCandidate")
            let response = data[0] as! Dictionary<String, Any>
            let candidateData = response["candidate"] as! Dictionary<String, Any>

            
//            if(self.pcDic[response["candidateSendID"] as! String] != nil) {
//                let peerConnection: RTCPeerConnection = self.pcDic[response["candidateSendID"] as! String]!
                let peerConnection: RTCPeerConnection = WebRTCDictionaryController.sharedInstance.pcDic[response["candidateSendID"] as! String]!
                
                let candidate = RTCIceCandidate(sdp: candidateData["candidate"] as! String, sdpMLineIndex: Int32(candidateData["sdpMLineIndex"] as! Int), sdpMid: candidateData["sdpMid"] as! String)

                peerConnection.add( candidate )
                
                
                let dic: [String: Any] = [
//                    "pcDic" : self.pcDic,
//                    "dcDic" : self.dcDic,
//    //                "volumeDic" : self.volumeDic
//                    "userArray" : self.userArray,
//                    "nameDic" : self.nameDic,
                    "pcDic" : WebRTCDictionaryController.sharedInstance.pcDic,
                    "dcDic" : WebRTCDictionaryController.sharedInstance.dcDic,
//                        "volumeDic" : self.volumeDic
                    "userArray" : WebRTCDictionaryController.sharedInstance.userArray,
                    "nameDic" : WebRTCDictionaryController.sharedInstance.nameDic
                ]
                
                handler(dic)
//            }
                
            

        }
    }


    func userExit(handler: @escaping (Any) -> Void) {
        socket.on("user_exit") {data, ack in
            print("user_exit")
            let response = data[0] as! Dictionary<String, String>

//            let peerConnection = self.pcDic[response["id"]!]
            let peerConnection = WebRTCDictionaryController.sharedInstance.pcDic[response["id"]!]
            if(peerConnection != nil) {
                peerConnection!.close()
                WebRTCDictionaryController.sharedInstance.pcDic.removeValue(forKey: response["id"]!)
            }
            
            print(response["id"])
//            let dcConnection = self.dcDic[response["id"]!]
            let dcConnection = WebRTCDictionaryController.sharedInstance.dcDic[response["id"]!]
            if(dcConnection != nil) {
                dcConnection!.close()
                WebRTCDictionaryController.sharedInstance.dcDic.removeValue(forKey: response["id"]!)
            }
//            self.pcDic.removeValue(forKey: response["id"]!)
//            self.dcDic.removeValue(forKey: response["id"]!)
//            self.nameDic.removeValue(forKey: response["id"]!)

//            self.volumeDic.removeValue(forKey: response["id"]!)
            VolumeController.sharedInstance.removeVolumeSetting(socketID: response["id"]!)
            var num = 0
            var num_check = 0
            var num_find = false
            WebRTCDictionaryController.sharedInstance.userArray.forEach {
                if($0 == response["id"]){
                    num_check = num
                    num_find = true
                }
                num = num + 1
            }
                        
            if(num_find) {
                WebRTCDictionaryController.sharedInstance.userArray.remove(at: num_check)
            }
            
            let dic: [String: Any] = [
                "pcDic" : WebRTCDictionaryController.sharedInstance.pcDic,
                "dcDic" : WebRTCDictionaryController.sharedInstance.dcDic,
//                        "volumeDic" : self.volumeDic
                "userArray" : WebRTCDictionaryController.sharedInstance.userArray,
                "nameDic" : WebRTCDictionaryController.sharedInstance.nameDic
            ]
            
            handler(dic)
        }
    }
    
    func exit() {
        
//        for key in self.pcDic.keys {
//            self.pcDic[key]?.close()
////            print("---------------------------------")
////            print("exit pcDic : \(self.pcDic[key])")
////            print("---------------------------------")
//        }
//
//        self.pcDic = [:]
//        for key in self.dcDic.keys {
//            self.dcDic[key]?.close()
////            print("---------------------------------")
////            print("exit dcDic : \(self.dcDic[key])")
////            print("---------------------------------")
//
//        }
//        self.dcDic = [:]
//        self.nameDic = [:]
//        self.userArray = []
        
        
        
        
        WebRTCDictionaryController.sharedInstance.pcDic = [:]
        WebRTCDictionaryController.sharedInstance.dcDic = [:]
        WebRTCDictionaryController.sharedInstance.nameDic = [:]
        WebRTCDictionaryController.sharedInstance.userArray = []
        
        VolumeController.sharedInstance.exitRoom()
        
    }

}


extension WebRTCClient: RTCPeerConnectionDelegate {

  func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
//    debugPrint("peerConnection new signaling state: \(stateChanged)")
      
      switch stateChanged {
      case .closed:
          print("peerConnection new signaling state: .closed")
      case .haveLocalOffer:
          print("peerConnection new signaling state: .haveLocalOffer")
      case .haveLocalPrAnswer:
          print("peerConnection new signaling state: .haveLocalPrAnswer")
      case .haveRemoteOffer:
          print("peerConnection new signaling state: .haveRemoteOffer")
      case .stable:
          print("peerConnection new signaling state: .stable")
      default:
          print("peerConnection new signaling state: ??")
      }
  }

  func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
    debugPrint("peerConnection did add stream")
//      print("-----------------------------------")
//      print(peerConnection)
//      print(stream.audioTracks[0].source)
//      stream.audioTracks[0].source.volume = -1
//      print("-----------------------------------")
      
  }

  func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
//    debugPrint("peerConnection did remove stream")
      print("peerConnection remove stream")
//      peerConnection.remove(stream)
  }

  func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
//    debugPrint("peerConnection should negotiate")
  }

  func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
//    debugPrint("peerConnection new connection state: \(newState)")
      
      switch newState {
      case .new:
          print("peerConnection new connection state: .new")
      case .closed:
          print("peerConnection new connection state: .closed")
      case .failed:
          print("peerConnection new connection state: .failed")
      case .disconnected:
          print("peerConnection new connection state: .disconnected")
      case .connected:
          print("peerConnection new connection state: .connected")
      case .count:
          print("peerConnection new connection state: .count")
      case .checking:
          print("peerConnection new connection state: .checking")
      case .completed:
          print("peerConnection new connection state: .completed")
      default:
          print("peerConnection new connection state: ??")
      }
      
      
      
      
    self.delegate?.webRTCClient(self, didChangeConnectionState: newState)
  }

  func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
//    debugPrint("peerConnection new gathering state: \(newState)")
  }

    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
//      print("peerConnection candidate ??11")
//      print(candidate)
      let sendCandidate: [String: Any] = [
        "candidate" : candidate.sdp,
        "sdpMid" : candidate.sdpMid,
        "sdpMLineIndex" : candidate.sdpMLineIndex
      ]
//        for key in self.pcDic.keys {
//            if(self.pcDic[key] == peerConnection) {
//                let data: [String: Any] = [
//                  "candidate" : sendCandidate,
//                  "candidateSendID" : socket.sid,
//                  "candidateReceiveID" : key
//                ]
//                self.socket.emit("candidate", data)
//                break
//            }
//        }
        
        for key in WebRTCDictionaryController.sharedInstance.pcDic.keys {
            if(WebRTCDictionaryController.sharedInstance.pcDic[key] == peerConnection) {
                let data: [String: Any] = [
                  "candidate" : sendCandidate,
                  "candidateSendID" : socket.sid,
                  "candidateReceiveID" : key
                ]
                self.socket.emit("candidate", data)
                break
            }
        }
        
    self.delegate?.webRTCClient(self, didDiscoverLocalCandidate: candidate)
  }

  func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
//      print("peerConnection remove candidate")
//      peerConnection.remove(candidates)
//    debugPrint("peerConnection did remove candidate(s)")
  }

  func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
    debugPrint("peerConnection did open data channel")
      print(dataChannel.label)
//      self.dcDic[dataChannel.label] = dataChannel
      WebRTCDictionaryController.sharedInstance.dcDic[dataChannel.label] = dataChannel
      
//      print("----------------------")
//      for key in dcDic.keys {
//          print(key)
//          print(dcDic[key]!.label)
//      }
//      print("----------------------")
  }
}

extension WebRTCClient: RTCDataChannelDelegate {
  func dataChannelDidChangeState(_ dataChannel: RTCDataChannel) {
//    debugPrint("dataChannel did change state: \(dataChannel.readyState)")
  }

  func dataChannel(_ dataChannel: RTCDataChannel, didReceiveMessageWith buffer: RTCDataBuffer) {

      
      print("data channel ?? : \(String.init(data: buffer.data, encoding: .utf8))")
      
      
      let decoder = JSONDecoder()

      do {
          
          print(type(of: buffer.data))
          let json = try decoder.decode(DataChannelCodableStruct.dataChannel.self, from: buffer.data)
       
          
        instrumentController.instrumentController(instrument: json)
          
//
      } catch {
          print(error.localizedDescription)
      }
//      self.delegate?.webRTCClient(self, didReceiveData: buffer.data)
  }

}




