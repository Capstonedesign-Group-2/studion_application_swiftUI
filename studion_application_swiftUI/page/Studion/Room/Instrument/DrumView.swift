//
//  DrumView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import SwiftUI
import WebRTC

struct DrumView: View {
    var dcDic: [String: Any]?
    
    let instrumentController = InstrumentController()
    
    let items = ["Q", "W", "E", "A", "S", "D", "Z", "X", "C"]
    let layout = [
        GridItem(.adaptive(minimum: 9, maximum: 9))
    ]
    
    var body: some View {
        VStack (spacing: 20){
//            Spacer()
//                .frame(height: 20)
            HStack (spacing: 20){
                
                Button(action: {
                    print("Q")
                    self.buttonClick(key: "Q")
                    
                }) {
                    Image("ride")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
                Button(action: {
                    print("W")
                    self.buttonClick(key: "W")
                }) {
                    Image("hi-hat")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
                Button(action: {
                    print("E")
                    self.buttonClick(key: "E")
                }) {
                    Image("snap")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
            }
            
            HStack (spacing: 20){
                
                Button(action: {
                    print("A")
                    self.buttonClick(key: "A")
                }) {
                    Image("tom")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
                Button(action: {
                    print("S")
                    self.buttonClick(key: "S")
                }) {
                    Image("tom")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
                Button(action: {
                    print("D")
                    self.buttonClick(key: "D")
                }) {
                    Image("tom")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                

            }
            
            HStack (spacing: 20){
                
                Button(action: {
                    print("Z")
                    self.buttonClick(key: "Z")
                }) {
                    Image("snap")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
                Button(action: {
                    print("X")
                    self.buttonClick(key: "X")
                }) {
                    Image("bass-drum")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
                Button(action: {
                    print("C")
                    self.buttonClick(key: "C")
                }) {
                    Image("snap")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                
            }
            Spacer()
        }
        
    }
    
    func buttonClick(key: String) {
        
        
        let data: [String: String] = [
            "type" : "drum",
            "key" : key,
            "socketId" : SocketIO.sharedInstance.getSocketIOId()
        ]
        
        let encorder = JSONEncoder()
        do {
            let jsonData = try? encorder.encode(data)
            
            for key in self.dcDic!.keys {
                let dataChannel: RTCDataChannel = self.dcDic![key] as! RTCDataChannel
                let buffer = RTCDataBuffer(data: jsonData!, isBinary: true)
                
                dataChannel.sendData(buffer)
                print("send data channel")
            }
        } catch {
            print("error")
        }
        
        instrumentController.drumController_my(key: key)
        
        
    }
}

