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
            
            VStack (spacing: 40){

    //            Spacer()
    //                .frame(height: 20)
                HStack (spacing: 40){

//                    Button(action: {
//                        print("Q")
//                        self.buttonClick(key: "Q")
//    //                    drumController_test.start(key: "cr")
//
//                    }) {
//                        Image("ride")
//                            .resizable()
//                            .frame(width: 120, height: 120)
//                            .aspectRatio(contentMode: .fit)
//                    }
//                    .buttonStyle(MyButtonStyle())
                    PayButton(key: "Q", imageName: "ride")
                    

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

//                    Button(action: {
//                        print("Q")
//                        self.buttonClick(key: "Q")
//    //                    drumController_test.start(key: "cr")
//
//                    }) {
//                        Image("ride")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                            .aspectRatio(contentMode: .fit)
//                    }
//                    .buttonStyle(MyButtonStyle())
                    PayButton(key: "Q", imageName: "ride")
                    

//                    Button(action: {
//                        print("W")
//                        self.buttonClick(key: "W")
//    //                    drumController_test.start(key: "tom3")
//
//
//                    }) {
//                        Image("hi-hat")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                            .aspectRatio(contentMode: .fit)
//
//                    }
//                    .buttonStyle(MyButtonStyle())
                    PayButton(key: "W", imageName: "hi-hat")

//                    Button(action: {
//                        print("E")
//                        self.buttonClick(key: "E")
//                    }) {
//                        Image("snap")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                            .aspectRatio(contentMode: .fit)
//                    }
//                    .buttonStyle(MyButtonStyle())
                    PayButton(key: "E", imageName: "snap")

                } // HStack

                HStack (spacing: 20){

//                    Button(action: {
//                        print("A")
//                        self.buttonClick(key: "A")
//    //                    self.conductor.playPad(padNumber: 3)
//                    }) {
//                        Image("tom")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                            .aspectRatio(contentMode: .fit)
//                    }
//                    .buttonStyle(MyButtonStyle())
                    
                    PayButton(key: "A", imageName: "tom")

//                    Button(action: {
//                        print("S")
//                        self.buttonClick(key: "S")
//    //                    self.conductor.playPad(padNumber: 4)
//                    }) {
//                        Image("tom")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                            .aspectRatio(contentMode: .fit)
//                    }
//                    .buttonStyle(MyButtonStyle())
                    PayButton(key: "S", imageName: "tom")

//                    Button(action: {
//                        print("D")
//                        self.buttonClick(key: "D")
//    //                    self.conductor.playPad(padNumber: 5)
//                    }) {
//                        Image("tom")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                            .aspectRatio(contentMode: .fit)
//                    }
//                    .buttonStyle(MyButtonStyle())
                    
                    PayButton(key: "D", imageName: "tom")


                } // HStack

                HStack (spacing: 20){

//                    Button(action: {
//                        print("Z")
//                        self.buttonClick(key: "Z")
//    //                    self.conductor.playPad(padNumber: 6)
//                    }) {
//                        Image("snap")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                            .aspectRatio(contentMode: .fit)
//                    }
//                    .buttonStyle(MyButtonStyle())
                    
                    PayButton(key: "Z", imageName: "snap")

//                    Button(action: {
//                        print("X")
//                        self.buttonClick(key: "X")
//    //                    self.conductor.playPad(padNumber: 7)
//                    }) {
//                        Image("bass-drum")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                            .aspectRatio(contentMode: .fit)
//                    }
//                    .buttonStyle(MyButtonStyle())
                    PayButton(key: "X", imageName: "bass-drum")

//                    Button(action: {
//                        print("C")
//                        self.buttonClick(key: "C")
//    //                    self.conductor.playPad(padNumber: 8)
//                    }) {
//                        Image("snap")
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                            .aspectRatio(contentMode: .fit)
//                    }
//                    .buttonStyle(MyButtonStyle())
                    PayButton(key: "C", imageName: "snap")

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


struct PayButton: View {
    var key: String
    var imageName: String
    
    let drumsController = DrumsController()
    
    @State var tap = false
    @State var press = false

    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 70, height: 70)
                .aspectRatio(contentMode: .fit)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
//                    .frame(width: 200, height: 60)
                    .background(
                        ZStack {
                                Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))

//                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                            Circle()
                                    .foregroundColor(.white)
                                    .blur(radius: 4)
                                    .offset(x: -8, y: -8)

//                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                            Circle()
                                    .fill(
                                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                    .padding(2)
                                    .blur(radius: 2)
                            }
                    )
                    .clipShape(Circle())
                    .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
                    .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(width: 70, height: 60)
        .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 0)))
        .edgesIgnoringSafeArea(.all)
        .scaleEffect(tap ? 1.2 : 1)
                .gesture(
                    LongPressGesture().onChanged { value in
                        self.tap = true
        
                        buttonClick(key: self.key)
        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.tap = false
                        }
                    }
                        .onEnded{ value in
                            self.press.toggle()
                        }
                )
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
            
        } catch {
            print("error")
        }

        self.drumsController.settings(key: key)

        
    }
}
