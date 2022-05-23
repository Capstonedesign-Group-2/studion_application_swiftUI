//
//  LeftBarView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import SwiftUI

struct LeftBarView: View {
    
    
    var userArray: [String]
    var nameDic: [String: String]
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State private var speed = 80.0
    @State private var isEditing = false
    
    @State private var masterVolume = 80.0
    @State private var myVolume = 80.0
    @State private var volume1 = 80.0
    @State private var volume2 = 80.0
    @State private var volume3 = 80.0
    @State private var volume4 = 80.0
    
    @State private var offset: CGFloat = 0
    @State private var offsetMe: CGFloat = 0
    @State private var offset1: CGFloat = 0
    @State private var offset2: CGFloat = 0
    @State private var offset3: CGFloat = 0
    @State private var offset4: CGFloat = 0
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    
    @State var MaxHeight: CGFloat = UIScreen.main.bounds.height
    
    let myName: String = (UserInfo.userInfo.user?.name)!
    
    var body: some View {
        
        HStack (spacing: 0) {
            VStack(alignment: .leading) {
                
                HStack {
                    Spacer()
                    
                    VStack {
                        Spacer()
                            .frame(height: (UIScreen.main.bounds.height / 8))
                        
                        
                        GeometryReader { geo in
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                
                                Capsule()
                                    .fill(Color.black.opacity(0.25))
                                    .frame(height:30)
                                
                                Capsule()
                                    
                                    .fill((WebRTCDictionaryController.sharedInstance.userArray.count >= 4) ? Color(#colorLiteral(red: 0, green: 0.5452187657, blue: 0, alpha: 0.8470588235)) : Color(red: 220/255, green: 226/255, blue: 240/255) )
                                    .frame(width: offset4 + 20, height:30)
                                    
                                
                                
                                
                                HStack(spacing: (UIScreen.main.bounds.height * 2/3) / 10) {
                                    ForEach(0..<10, id: \.self) {index in
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: index % 2 == 0 ? 7 : 4, height : index  % 2 == 0 ? 7 : 4)
                                    }
                                }
                                
                                
                                Circle()
                                    .fill((WebRTCDictionaryController.sharedInstance.userArray.count >= 4) ? Color(red: 7/255, green: 85/255, blue: 59/255) : Color( red: 80/255, green: 88/255, blue: 108/255))
                                    .frame(width: 50, height: 50)
                                    .background(Circle().stroke(Color.white, lineWidth: 5))
                                    .overlay(
                                        Text((WebRTCDictionaryController.sharedInstance.userArray.count >= 4) ? WebRTCDictionaryController.sharedInstance.nameDic[WebRTCDictionaryController.sharedInstance.userArray[3]]! : "Not")
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                            .lineLimit(1)
                                            .foregroundColor(Color(red: 252/255, green: 246/255, blue: 245/255))
                                            .rotationEffect(.degrees(90.0))
                                    )
                                    .offset(x: offset4)
                                    .gesture(DragGesture().onChanged( { (value) in
                                        
                                        if ((WebRTCDictionaryController.sharedInstance.userArray.count >= 4)) {
                                            if value.location.x >= 20 && value.location.x <= UIScreen.main.bounds.height * 2/3 + 20{
                                                offset3 = value.location.x - 20
        //                                            print((geo.size.height - 90) - 20)
                                                let percent = (UIScreen.main.bounds.height * 2/3)
        //                                            print(Int(round(offset / percent)))
                                                let thisPercent = round(offset4 / percent * 100)
                                                
                                                
                                                VolumeController.sharedInstance.setVolume(socketID: WebRTCDictionaryController.sharedInstance.userArray[3], volume: thisPercent / 100)
                                                
                                            }
                                        }
                                        
                                    } ))
                                    
                                    .onAppear{
                                        let percent = (UIScreen.main.bounds.width * 2/3)
                                        offset4 = percent * 0.8
                                        
                                    }
                                    
                                    
                                
                            }   // ZStack
                            .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                            .frame(width: UIScreen.main.bounds.height * 2/3)
                            .offset(y: UIScreen.main.bounds.height * 2/3)
                            
                        }
                    }
                    
                    VStack {
                        Spacer()
                            .frame(height: (UIScreen.main.bounds.height / 8))
                        
                        
                        GeometryReader { geo in
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                
                                Capsule()
                                    .fill(Color.black.opacity(0.25))
                                    .frame(height:30)
                                
                                Capsule()
                                    
                                    .fill((WebRTCDictionaryController.sharedInstance.userArray.count >= 3) ? Color(#colorLiteral(red: 0, green: 0.5452187657, blue: 0, alpha: 0.8470588235)) : Color(red: 220/255, green: 226/255, blue: 240/255))
                                    .frame(width: offset3 + 20, height:30)
                                    
                                
                                
                                
                                HStack(spacing: (UIScreen.main.bounds.height * 2/3) / 10) {
                                    ForEach(0..<10, id: \.self) {index in
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: index % 2 == 0 ? 7 : 4, height : index  % 2 == 0 ? 7 : 4)
                                    }
                                }
                                
                                
                                Circle()
                                    .fill((WebRTCDictionaryController.sharedInstance.userArray.count >= 3) ? Color(red: 7/255, green: 85/255, blue: 59/255) : Color( red: 80/255, green: 88/255, blue: 108/255))
                                    .frame(width: 50, height: 50)
                                    .background(Circle().stroke(Color.white, lineWidth: 5))
                                    .overlay(
                                        Text((WebRTCDictionaryController.sharedInstance.userArray.count >= 3) ? WebRTCDictionaryController.sharedInstance.nameDic[WebRTCDictionaryController.sharedInstance.userArray[2]]! : "Not")
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                            .lineLimit(1)
                                            .foregroundColor(Color(red: 252/255, green: 246/255, blue: 245/255))
                                            .rotationEffect(.degrees(90.0))
                                    )
                                    .offset(x: offset3)
                                    .gesture(DragGesture().onChanged( { (value) in
                                        
                                        if ((WebRTCDictionaryController.sharedInstance.userArray.count >= 3)) {
                                            if value.location.x >= 20 && value.location.x <= UIScreen.main.bounds.height * 2/3 + 20{
                                                offset3 = value.location.x - 20
        //                                            print((geo.size.height - 90) - 20)
                                                let percent = (UIScreen.main.bounds.height * 2/3)
        //                                            print(Int(round(offset / percent)))
                                                let thisPercent = round(offset3 / percent * 100)
                                                
                                                
                                                VolumeController.sharedInstance.setVolume(socketID: WebRTCDictionaryController.sharedInstance.userArray[2], volume: thisPercent / 100)
                                                
                                            }
                                        }
                                        
                                    } ))
                                    
                                    .onAppear{
                                        let percent = (UIScreen.main.bounds.width * 2/3)
                                        offset3 = percent * 0.8
                                        
                                    }
                                    
                                    
                                
                            }   // ZStack
                            .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                            .frame(width: UIScreen.main.bounds.height * 2/3)
                            .offset(y: UIScreen.main.bounds.height * 2/3)
                            
                        }
                        
                    }
                    
                    VStack {
                        Spacer()
                            .frame(height: (UIScreen.main.bounds.height / 8))
                        
                        
                        GeometryReader { geo in
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                
                                Capsule()
                                    .fill(Color.black.opacity(0.25))
                                    .frame(height:30)
                                
                                Capsule()
                                    
                                    .fill((WebRTCDictionaryController.sharedInstance.userArray.count >= 2) ? Color(#colorLiteral(red: 0, green: 0.5452187657, blue: 0, alpha: 0.8470588235)) : Color(red: 220/255, green: 226/255, blue: 240/255))
                                    .frame(width: offset2 + 20, height:30)
                                    
                                
                                
                                
                                HStack(spacing: (UIScreen.main.bounds.height * 2/3) / 10) {
                                    ForEach(0..<10, id: \.self) {index in
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: index % 2 == 0 ? 7 : 4, height : index  % 2 == 0 ? 7 : 4)
                                    }
                                }
                                
                                
                                Circle()
                                    .fill((WebRTCDictionaryController.sharedInstance.userArray.count >= 2) ? Color(red: 7/255, green: 85/255, blue: 59/255) : Color( red: 80/255, green: 88/255, blue: 108/255))
                                    .frame(width: 50, height: 50)
                                    .background(Circle().stroke(Color.white, lineWidth: 5))
                                    .overlay(
                                        Text((WebRTCDictionaryController.sharedInstance.userArray.count >= 2) ? WebRTCDictionaryController.sharedInstance.nameDic[WebRTCDictionaryController.sharedInstance.userArray[1]]! : "Not")
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                            .lineLimit(1)
                                            .foregroundColor(Color(red: 252/255, green: 246/255, blue: 245/255))
                                            .rotationEffect(.degrees(90.0))
                                    )
                                    .offset(x: offset2)
                                    .gesture(DragGesture().onChanged( { (value) in
                                        
                                        if ((WebRTCDictionaryController.sharedInstance.userArray.count >= 2)) {
                                            if value.location.x >= 20 && value.location.x <= UIScreen.main.bounds.height * 2/3 + 20{
                                                offset2 = value.location.x - 20
        //                                            print((geo.size.height - 90) - 20)
                                                let percent = (UIScreen.main.bounds.height * 2/3)
        //                                            print(Int(round(offset / percent)))
                                                let thisPercent = round(offset2 / percent * 100)
                                                
                                                
                                                VolumeController.sharedInstance.setVolume(socketID: WebRTCDictionaryController.sharedInstance.userArray[1], volume: thisPercent / 100)
                                                
                                            }
                                        }
                                        
                                    } ))
                                    
                                    .onAppear{
                                        let percent = (UIScreen.main.bounds.width * 2/3)
                                        offset2 = percent * 0.8
                                        
                                    }
                                    
                                    
                                
                            }   // ZStack
                            .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                            .frame(width: UIScreen.main.bounds.height * 2/3)
                            .offset(y: UIScreen.main.bounds.height * 2/3)
                            
                        }
                        
                    }
                    
                    
                    
                    VStack {
                        Spacer()
                            .frame(height: (UIScreen.main.bounds.height / 8))
                        
                        
                        GeometryReader { geo in
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                
                                Capsule()
                                    .fill(Color.black.opacity(0.25))
                                    .frame(height:30)
                                
                                Capsule()
                                    
                                    .fill((WebRTCDictionaryController.sharedInstance.userArray.count >= 1) ? Color(#colorLiteral(red: 0, green: 0.5452187657, blue: 0, alpha: 0.8470588235)) : Color(red: 220/255, green: 226/255, blue: 240/255))
                                    .frame(width: offset1 + 20, height:30)
                                    
                                
                                
                                
                                HStack(spacing: (UIScreen.main.bounds.height * 2/3) / 10) {
                                    ForEach(0..<10, id: \.self) {index in
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: index % 2 == 0 ? 7 : 4, height : index  % 2 == 0 ? 7 : 4)
                                    }
                                }
                                
                                
                                Circle()
                                    .fill((WebRTCDictionaryController.sharedInstance.userArray.count >= 1) ? Color(red: 7/255, green: 85/255, blue: 59/255) : Color( red: 80/255, green: 88/255, blue: 108/255))
                                    .frame(width: 50, height: 50)
                                    .background(Circle().stroke(Color.white, lineWidth: 5))
                                    .overlay(
                                        Text((WebRTCDictionaryController.sharedInstance.userArray.count >= 1) ? WebRTCDictionaryController.sharedInstance.nameDic[WebRTCDictionaryController.sharedInstance.userArray[0]]! : "Not")
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                            .lineLimit(1)
                                            .foregroundColor(Color(red: 252/255, green: 246/255, blue: 245/255))
                                            .rotationEffect(.degrees(90.0))
                                    )
                                    .offset(x: offset1)
                                    .gesture(DragGesture().onChanged( { (value) in
                                        
                                        if ((WebRTCDictionaryController.sharedInstance.userArray.count >= 1)) {
                                            if value.location.x >= 20 && value.location.x <= UIScreen.main.bounds.height * 2/3 + 20{
                                                offset1 = value.location.x - 20
        //                                            print((geo.size.height - 90) - 20)
                                                let percent = (UIScreen.main.bounds.height * 2/3)
        //                                            print(Int(round(offset / percent)))
                                                let thisPercent = round(offset1 / percent * 100)
                                                
                                                
                                                VolumeController.sharedInstance.setVolume(socketID: WebRTCDictionaryController.sharedInstance.userArray[0], volume: thisPercent / 100)
                                                
                                            }
                                        }
                                        
                                    } ))
                                    
                                    .onAppear{
                                        let percent = (UIScreen.main.bounds.width * 2/3)
                                        offset1 = percent * 0.8
                                        
                                    }
                                    
                                    
                                
                            }   // ZStack
                            .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                            .frame(width: UIScreen.main.bounds.height * 2/3)
                            .offset(y: UIScreen.main.bounds.height * 2/3)
                            
                        }
                        
                        
                    }
                    
                    
                    VStack {
                        
                        
                        Spacer()
                            .frame(height: (UIScreen.main.bounds.height / 8))
                        
                        
                        GeometryReader { geo in
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                
                                Capsule()
                                    .fill(Color.black.opacity(0.25))
                                    .frame(height:30)
                                
                                Capsule()
                                    
                                    .fill(Color(#colorLiteral(red: 0, green: 0.5452187657, blue: 0, alpha: 0.8470588235)))
                                    .frame(width: offsetMe + 20, height:30)
                                    
                                
                                
                                
                                HStack(spacing: (UIScreen.main.bounds.height * 2/3) / 10) {
                                    ForEach(0..<10, id: \.self) {index in
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: index % 2 == 0 ? 7 : 4, height : index  % 2 == 0 ? 7 : 4)
                                    }
                                }
                                
                                
                                Circle()
                                    .fill(Color(red: 7/255, green: 85/255, blue: 59/255))
                                    .frame(width: 50, height: 50)
                                    .background(Circle().stroke(Color.white, lineWidth: 5))
                                    .overlay(
                                        Text(self.myName)
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(red: 252/255, green: 246/255, blue: 245/255))
                                            .lineLimit(1)
                                            .rotationEffect(.degrees(90.0))
                                    )
                                    .offset(x: offsetMe)
                                    .gesture(DragGesture().onChanged( { (value) in
                                        
                                        if value.location.x >= 20 && value.location.x <= UIScreen.main.bounds.height * 2/3 + 20{
                                            offsetMe = value.location.x - 20
    //                                            print((geo.size.height - 90) - 20)
                                            let percent = (UIScreen.main.bounds.height * 2/3)
    //                                            print(Int(round(offset / percent)))
                                            let thisPercent = round(offsetMe / percent * 100)
                                            
                                            
                                            VolumeController.sharedInstance.setVolume(socketID: "me", volume: thisPercent / 100)
                                            
                                        }
                                    } ))
                                    
                                    .onAppear{
                                        let percent = (UIScreen.main.bounds.width * 2/3)
                                        offsetMe = percent * 0.8
                                        
                                    }
                                    
                                    
                                
                            }   // ZStack
                            .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                            .frame(width: UIScreen.main.bounds.height * 2/3)
                            .offset(y: UIScreen.main.bounds.height * 2/3)
                            
                        }
                        
                        
                        
                    }   // VStack (My Volume)
                    
                    VStack {
                        Spacer()
                            .frame(height: (UIScreen.main.bounds.height / 8))
                        
                        
                        GeometryReader { geo in
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                
                                Capsule()
                                    .fill(Color.black.opacity(0.25))
                                    .frame(height:30)
                                
                                Capsule()
                                    
                                    .fill(Color(red: 240/255, green: 237/255, blue: 204/255))
                                    .frame(width: offset + 20, height:30)
                                    
                                
                                
                                
                                HStack(spacing: (UIScreen.main.bounds.height * 2/3) / 10) {
                                    ForEach(0..<10, id: \.self) {index in
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: index % 2 == 0 ? 7 : 4, height : index  % 2 == 0 ? 7 : 4)
                                    }
                                }
                                
                                
                                Circle()
                                    .fill(Color(red: 2/255, green: 52/255, blue: 63/255))
                                    .frame(width: 50, height: 50)
                                    .background(Circle().stroke(Color.white, lineWidth: 5))
                                    .overlay(
                                        Text("M")
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                            .lineLimit(1)
                                            .foregroundColor(Color(red: 252/255, green: 246/255, blue: 245/255))
                                            .rotationEffect(.degrees(90.0))
                                    )
                                    .offset(x: offset)
                                    .gesture(DragGesture().onChanged( { (value) in
                                        
                                        if value.location.x >= 20 && value.location.x <= UIScreen.main.bounds.height * 2/3 + 20{
                                            offset = value.location.x - 20
    //                                            print((geo.size.height - 90) - 20)
                                            let percent = (UIScreen.main.bounds.height * 2/3)
    //                                            print(Int(round(offset / percent)))
                                            let thisPercent = round(offset / percent * 100)
                                            
                                            
                                            VolumeController.sharedInstance.setMasterVolume(masterVolume: thisPercent / 100)
                                            
                                        }
                                    } ))
                                    
                                    .onAppear{
                                        let percent = (UIScreen.main.bounds.width * 2/3)
                                        offset = percent * 0.8
                                        
                                    }
                                    
                                    
                                
                            }   // ZStack
                            .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                            .frame(width: UIScreen.main.bounds.height * 2/3)
                            .offset(y: UIScreen.main.bounds.height * 2/3)
                            
                        }
                        
                        
                        
                    } // VStack (Master Volume)
                    
                    
                    
                } // HStack
                
                
                
            
            } // VStack

            .padding(.horizontal, 20)
            .padding(.top, edges!.top == 0 ? 15 : edges?.top)
            .padding(.top, edges!.bottom == 0 ? 15 : edges?.bottom)
            .frame(width: UIScreen.main.bounds.width * 4/5)
            .background(Color.white)
//            .ignoresSafeArea(.all, edges: .vertical)

            Spacer(minLength: 0)
            
        
        } // HStack
        .onAppear{
            print("leftbar")
//            print(WebRTCDictionaryController.sharedInstance.userArray)
        }
        
        
            
    }
    
}



