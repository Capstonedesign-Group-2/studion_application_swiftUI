////
////  DrumView.swift
////  studion_application_swiftUI
////
////  Created by 김진홍 on 2022/03/24.
////
//
import SwiftUI
import WebRTC
import Combine
import AVFoundation

struct DrumView: View {
    
    

    var dcDic: [String: Any]?

    let instrumentController = InstrumentController()
//    let drumsController = DrumsControllerAudioKit()
    
    
    
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
                .buttonStyle(MyButtonStyle())
                

                Button(action: {
                    print("W")
                    self.buttonClick(key: "W")


                }) {
                    Image("hi-hat")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)

                }
                .buttonStyle(MyButtonStyle())

                Button(action: {
                    print("E")
                    self.buttonClick(key: "E")
                }) {
                    Image("snap")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(MyButtonStyle())

            } // HStack

            HStack (spacing: 20){

                Button(action: {
                    print("A")
                    self.buttonClick(key: "A")
//                    self.conductor.playPad(padNumber: 3)
                }) {
                    Image("tom")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(MyButtonStyle())

                Button(action: {
                    print("S")
                    self.buttonClick(key: "S")
//                    self.conductor.playPad(padNumber: 4)
                }) {
                    Image("tom")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(MyButtonStyle())

                Button(action: {
                    print("D")
                    self.buttonClick(key: "D")
//                    self.conductor.playPad(padNumber: 5)
                }) {
                    Image("tom")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(MyButtonStyle())


            } // HStack

            HStack (spacing: 20){

                Button(action: {
                    print("Z")
                    self.buttonClick(key: "Z")
//                    self.conductor.playPad(padNumber: 6)
                }) {
                    Image("snap")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(MyButtonStyle())

                Button(action: {
                    print("X")
                    self.buttonClick(key: "X")
//                    self.conductor.playPad(padNumber: 7)
                }) {
                    Image("bass-drum")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(MyButtonStyle())

                Button(action: {
                    print("C")
                    self.buttonClick(key: "C")
//                    self.conductor.playPad(padNumber: 8)
                }) {
                    Image("snap")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(MyButtonStyle())

            } // HStack

            Spacer()

        } // Vstack
        

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

        
        let drumsController = DrumsController()
        drumsController.setting(key: key)
        drumsController.playOrPause()
        
//        drumsControllerAudioKit.playPad(padNumber: 0)
        
//        self.drumsController.play()
        
    }
}


struct MyButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .onLongPressGesture(
                minimumDuration: 0,
                perform: configuration.trigger
            )
    }
}
