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
//    let drumController_test = DrumController_test()
    let drumsController = DrumsController()
    
    
    let items = ["Q", "W", "E", "A", "S", "D", "Z", "X", "C"]
    let layout = [
        GridItem(.adaptive(minimum: 9, maximum: 9))
    ]
    

    var body: some View {
        
        
        if UIDevice.isIpad {
            
            VStack (spacing: 40) {

    //            Spacer()
    //                .frame(height: 20)
                HStack (spacing: 40){

                    Button(action: {
                        print("Q")
                        print("X")
                        self.buttonClick(key: "Q")
                        self.buttonClick(key: "X")
    //                    drumController_test.start(key: "cr")
                        
                    }) {
                        Image("ride")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .aspectRatio(contentMode: .fit)
                    }
                    .buttonStyle(MyButtonStyle())
                    

                    Button(action: {
                        print("W")
                        self.buttonClick(key: "W")
    //                    drumController_test.start(key: "tom3")


                    }) {
                        Image("hi-hat")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .aspectRatio(contentMode: .fit)

                    }
                    .buttonStyle(MyButtonStyle())

                    Button(action: {
                        print("E")
                        self.buttonClick(key: "E")
                    }) {
                        Image("snap")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .aspectRatio(contentMode: .fit)
                    }
                    .buttonStyle(MyButtonStyle())

                } // HStack

                HStack (spacing: 40){

                    Button(action: {
                        print("A")
                        self.buttonClick(key: "A")
    //                    self.conductor.playPad(padNumber: 3)
                    }) {
                        Image("tom")
                            .resizable()
                            .frame(width: 120, height: 120)
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
                            .frame(width: 120, height: 120)
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
                            .frame(width: 120, height: 120)
                            .aspectRatio(contentMode: .fit)
                    }
                    .buttonStyle(MyButtonStyle())


                } // HStack

                HStack (spacing: 40){

                    Button(action: {
                        print("Z")
                        self.buttonClick(key: "Z")
    //                    self.conductor.playPad(padNumber: 6)
                    }) {
                        Image("snap")
                            .resizable()
                            .frame(width: 120, height: 120)
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
                            .frame(width: 120, height: 120)
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
                            .frame(width: 120, height: 120)
                            .aspectRatio(contentMode: .fit)
                    }
                    .buttonStyle(MyButtonStyle())

                } // HStack

                Spacer()

            } // Vstack
            .safeAreaInset(edge: .top, alignment: .center, spacing: 0) {
                Color.clear
                    .frame(height: 50)
                  .background(Material.bar)
            }
            .onAppear{
                print("drum start")
            }
            .onDisappear{
                print("drum end")
            }
            
        } else { // iPhone View
            
            VStack (spacing: 20){

//                Spacer()
    //                .frame(height: 20)
                HStack (spacing: 20){

                    Button(action: {
                        print("Q")
                        print("X")
                        self.buttonClick(key: "Q")
                        self.buttonClick(key: "X")
    //                    drumController_test.start(key: "cr")
                        
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
    //                    drumController_test.start(key: "tom3")


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

//                Spacer()

            } // Vstack
            .onAppear{
                print("drum start")
            }
            .onDisappear{
                print("drum end")
            }
            
        }
    }

    func buttonClick(key: String) {


        let data: [String: String] = [
            "type" : "drum",
            "key" : key,
            "socketId" : SocketIO.sharedInstance.getSocketIOId()
        ]
        let encorder = JSONEncoder()
        
//        print(self.dcDic)
        
        do {
            let jsonData = try? encorder.encode(data)

            for key in WebRTCDictionaryController.sharedInstance.dcDic.keys {
                let dataChannel: RTCDataChannel = WebRTCDictionaryController.sharedInstance.dcDic[key] as! RTCDataChannel
                let buffer = RTCDataBuffer(data: jsonData!, isBinary: true)
//
                dataChannel.sendData(buffer)

            }
//            for dc in dcArray {
//                let dataChannel = dc as! RTCDataChannel
//
//                let buffer = RTCDataBuffer(data: jsonData!, isBinary: true)
//                dataChannel.sendData(buffer)
//            }
            
        } catch {
            print("error")
        }

        self.drumsController.settings(key: key)

        
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
