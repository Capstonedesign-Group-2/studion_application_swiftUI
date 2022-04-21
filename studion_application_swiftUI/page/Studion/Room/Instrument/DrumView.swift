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
    
    
    let items = ["Q", "W", "E", "A", "S", "D", "Z", "X", "C"]
    let layout = [
        GridItem(.adaptive(minimum: 9, maximum: 9))
    ]
    

    var body: some View {
        
        
        if UIDevice.isIpad {
            
            
            
            ZStack {
                
                VStack (spacing: 20){

    //                Spacer()
        //                .frame(height: 20)
                    HStack (spacing: 100){
                        
                        PayButton(key: "Q", imageName: "ride")

                        PayButton(key: "W", imageName: "hi-hat")

                        PayButton(key: "E", imageName: "ride")

                    } // HStack

                    HStack (spacing: 100){
                        
                        PayButton(key: "A", imageName: "tom")

                        PayButton(key: "S", imageName: "tom")
                        
                        PayButton(key: "D", imageName: "tom")

                    } // HStack

                    HStack (spacing: 100){
                        
                        PayButton(key: "Z", imageName: "snap")

                        PayButton(key: "X", imageName: "bass-drum")

                        PayButton(key: "C", imageName: "snap")

                    } // HStack

    //                Spacer()

                } // Vstack
                
                
                .safeAreaInset(edge: .top, alignment: .center, spacing: 0) {
                    Color.clear
                        .frame(height: 50)
    //                  .background(Material.bar)
                }
                .onAppear{
                    print("drum start")
                }
                .onDisappear{
                    print("drum end")
                }
            }
            
        } else { // iPhone View
            
            VStack (spacing: 20){

//                Spacer()
    //                .frame(height: 20)
                HStack (spacing: 20){
                    
                    PayButton(key: "Q", imageName: "ride")

                    PayButton(key: "W", imageName: "hi-hat")

                    PayButton(key: "E", imageName: "ride")

                } // HStack

                HStack (spacing: 20){
                    
                    PayButton(key: "A", imageName: "tom")

                    PayButton(key: "S", imageName: "tom")
                    
                    PayButton(key: "D", imageName: "tom")

                } // HStack

                HStack (spacing: 20){
                    
                    PayButton(key: "Z", imageName: "snap")

                    PayButton(key: "X", imageName: "bass-drum")

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

//        self.drumsController.settings(key: key)
        

        
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
    
    let instrumentController = InstrumentController()
    
    @State var tap = false
    @State var press = false

    
    var body: some View {
        
        if UIDevice.isIpad {
            
            
            VStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 150, height: 150) //btn size
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
            .frame(width: 150, height: 160) // Size (all)
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
            
            
        } else {
            
            VStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 70, height: 70) //btn size
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
            .frame(width: 70, height: 60) // Size (all)
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

//        self.drumsController.settings(key: key)
        let selfDataChannel: DataChannelCodableStruct.dataChannel = DataChannelCodableStruct.dataChannel(type: "drum", key: key, socketId: "me")
        
        instrumentController.instrumentController(instrument: selfDataChannel)
        
    }
}
