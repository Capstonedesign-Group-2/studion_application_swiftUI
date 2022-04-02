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
    
    
    @State var MaxHeight: CGFloat = UIScreen.main.bounds.height
    
    let myName: String = (UserInfo.userInfo.user?.name)!
    
    var body: some View {
        
        HStack (spacing: 0) {
            
            VStack(alignment: .leading) {
                
                HStack {
                    Spacer()
                    
                    
                    VStack {
                        
                        if userArray.count >= 4 {
                            Spacer()
                                .frame(height: 20)
                            
                            Text(nameDic[userArray[3]]!)
                                .padding(.trailing, 30)
                            GeometryReader { geo in

                                Slider(
                                    value: $volume4,
                                    in: 0...100,
                                    step: 1
                                )
                                    .onChange(of: volume4, perform: {newVolume in
                                        VolumeController.sharedInstance.setVolume(socketID: userArray[3], volume: newVolume / 100)
                                    })
                                    .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                                    .frame(width: geo.size.height * 3/4)
                                .offset(y: geo.size.height * 3/4)
                                

                            }
                        } else {
                            GeometryReader { geo in

                                Spacer()
                                    .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                                    .frame(width: geo.size.height * 3/4)
                                .offset(y: geo.size.height * 3/4)

                            }

                        }
                        
                    } // VStack
                    
                    VStack {
                        
                        if userArray.count >= 3 {
                            Spacer()
                                .frame(height: 20)
                            
                            Text(nameDic[userArray[2]]!)
                                .padding(.trailing, 30)
                            GeometryReader { geo in

                                Slider(
                                    value: $volume3,
                                    in: 0...100,
                                    step: 1
                                )
                                    .onChange(of: volume3, perform: {newVolume in
                                        VolumeController.sharedInstance.setVolume(socketID: userArray[2], volume: newVolume / 100)
                                    })
                                    .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                                    .frame(width: geo.size.height * 3/4)
                                .offset(y: geo.size.height * 3/4)
                                

                            }
                        } else {
                            GeometryReader { geo in

                                Spacer()
                                    .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                                    .frame(width: geo.size.height * 3/4)
                                .offset(y: geo.size.height * 3/4)

                            }

                        }
                        
                    } // VStack
                    VStack {
                        
                        if userArray.count >= 2 {
                            Spacer()
                                .frame(height: 20)
                            
                            Text(nameDic[userArray[1]]!)
                                .padding(.trailing, 30)
                            GeometryReader { geo in

                                Slider(
                                    value: $volume2,
                                    in: 0...100,
                                    step: 1
                                )
                                    .onChange(of: volume2, perform: {newVolume in
                                        VolumeController.sharedInstance.setVolume(socketID: userArray[1], volume: newVolume / 100)
                                        print(userArray[1])
                                    })
                                    .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                                    .frame(width: geo.size.height * 3/4)
                                .offset(y: geo.size.height * 3/4)
                                

                            }
                        }
                        else {
                            GeometryReader { geo in

                                Spacer()
                                    .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                                    .frame(width: geo.size.height * 3/4)
                                .offset(y: geo.size.height * 3/4)

                            }

                        }
                        
                    } // VStack
                    
                    VStack {
                        
                        if userArray.count >= 1 {
                            Spacer()
                                .frame(height: 20)
                            
                            Text(nameDic[userArray[0]]!)
                                .padding(.trailing, 30)
                            GeometryReader { geo in

                                Slider(
                                    value: $volume1,
                                    in: 0...100,
                                    step: 1
                                )
                                    .onChange(of: volume1, perform: {newVolume in
                                        VolumeController.sharedInstance.setVolume(socketID: userArray[0], volume: newVolume / 100)
                                    })
                                    .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                                    .frame(width: geo.size.height * 3/4)
                                .offset(y: geo.size.height * 3/4)
                                
                                

                            }
                        } else {
                            GeometryReader { geo in

                                Spacer()
                                    .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                                    .frame(width: geo.size.height * 3/4)
                                .offset(y: geo.size.height * 3/4)
                                

                            }

                        }
                        
                        
                    } // VStack
                    
                    
                    
                    
                    
                    
                    VStack {
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Text(self.myName)
                            .padding(.trailing, 30)
                        
                        GeometryReader { geo in

                            Slider(
                                value: $myVolume,
                                in: 0...100,
                                step: 1
                            )
                                .onChange(of: myVolume, perform: {newVolume in
                                    VolumeController.sharedInstance.setVolume(socketID: "me", volume: newVolume / 100)
                                })
                                .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                                .frame(width: geo.size.height * 3/4)
                            .offset(y: geo.size.height * 3/4)
                            

                        }
                        
                    } // VStack
                    
                    VStack {
                        Spacer()
                            .frame(height: 20)
                        
                        Text("Master")
                            .padding(.trailing, 30)
                        GeometryReader { geo in

                            Slider(
                                value: $masterVolume,
                                in: 0...100,
                                step: 1
                            ).onChange(of: masterVolume, perform: { newVolume in
                                VolumeController.sharedInstance.setMasterVolume(masterVolume: newVolume / 100)
                            })
                                
                                .rotationEffect(.degrees(-90.0), anchor: .topLeading)
                                .frame(width: geo.size.height * 3/4)
                            .offset(y: geo.size.height * 3/4)
                            

                        }
                        
                    } // VStack
                    
                    
                    
                    
                    
                } // HStack
                
            
            } // VStack

            .padding(.horizontal, 20)
            .padding(.top, edges!.top == 0 ? 15 : edges?.top)
            .padding(.top, edges!.bottom == 0 ? 15 : edges?.bottom)
            .frame(width: UIScreen.main.bounds.width * 4/5)
            .background(Color.white)
            .ignoresSafeArea(.all, edges: .vertical)

            Spacer(minLength: 0)
        } // HStack
        .onAppear{
            print("leftbar")
            print(userArray)
        }
        
        
            
    }
    
}




