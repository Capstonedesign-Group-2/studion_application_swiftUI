//
//  NobodyView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/15.
//

import SwiftUI

struct NobodyView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State private var offset: CGFloat = 0
    @State private var offsetMe: CGFloat = 0
    let myName: String = (UserInfo.userInfo.user?.name)!
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                        .frame(height: (UIScreen.main.bounds.height / 8))
                    
                    
                    GeometryReader { geo in
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                            
                            
                                
                                
                                
                            
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
                                
                                .fill(Color(#colorLiteral(red: 0, green: 0.5452187657, blue: 0, alpha: 0.8470588235)))
                                .frame(width: offset + 20, height:30)
                                
                            
                            
                            
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
                                    Text("M")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
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
        .ignoresSafeArea(.all, edges: .vertical)

        Spacer(minLength: 0)
        
    }
}

