//
//  InstrumentControllerView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import SwiftUI
import AVFoundation

var instrument = ["drum", "piano_button", "guitar", "rec"]
struct InstrumentControllerView: View {
//    @Binding var mainRouter: String
//    @Binding var pageStatus: String
    @Binding var selectRoomCheck: Bool
    
    var dcDic:[String: Any]
    var pcDic:[String: Any]
    var userArray:[String]
    var nameDic: [String: String]
    
    
    
    @State var selectedTab = "drum"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    @State var showLeftMenu: Bool = false
    @State var showRightMenu: Bool = false
    @State var width = UIScreen.main.bounds.height
    
    
    @State var isRecording = false
    let recordController = RecordController()
    @State var recordFiles: [URL] = []
    
    var body: some View {
        
        if UIDevice.isIpad{
            
//            NavigationView {
                ZStack {
                    VStack{
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                            TabView(selection: $selectedTab) {

                                DrumView(dcDic: dcDic)
                                    .tag("drum")



                            PianoView(pcDic: pcDic, dcDic: dcDic)
                                .tag("piano_button")

                                GuitarView()
                                    .tag("guitar")
                                
                                RecordView(recordFiles: $recordFiles)
                                    .tag("rec")

                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .ignoresSafeArea(.all, edges: .bottom)
                            
                            
                            
                            
                            HStack(spacing: 0) {
                                ForEach(instrument, id: \.self) { image in
                                    InstrumentButton(image: image, selectedTab: $selectedTab)
                                    
                                    if image != instrument.last {
                                        Spacer(minLength: 0)
                                    }
                                }
                            }
                            .padding(.horizontal, 25)
                            .padding(.vertical, 5)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x:5, y: 5)
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
                            .padding(.horizontal)
                            .padding(.bottom, edge!.bottom == 0 ? 20: 0)
                            
                            
                            
                            
                        }  // ZStack
                        Spacer()
                        
                        
                    } // VStack
                    
                    
                    
                    LeftBarView(userArray: userArray, nameDic: nameDic)
                        .offset(x: showLeftMenu ? -0 : -(width))
                        .background(Color.black.opacity(showLeftMenu ? 0.5 : 0).ignoresSafeArea(.all))
                    
                    
                } // ZStack
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        
                        Button( action: {
                            print("left button")
                            withAnimation(.spring()){self.showLeftMenu.toggle()}
                            
                            
                        }) {
                            HStack {
                                if showRightMenu == false {
                                    if showLeftMenu {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .font(.title)
                                            .offset(y: 20)
                                    } else {
                                        Image(systemName: "speaker.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .font(.title)
                                            .offset(y: 20)
                                    }
                                }
                                
                                Button( action: {
                                    print("record")
                                    
                                    if isRecording {
                                        
    //                                    Task {
    //                                        do {
    //                                            let url = try await self.recordController.stopRecording()
    //                                            self.recordFiles.append(url)
    //                                            isRecording = false
    //
    //
    //                                        } catch {
    //                                            print(error.localizedDescription)
    //                                        }
    //                                    }
//                                        let url: URL? = AudioEngineController.sharedInstance.stop()
                                        
//                                        if(url != nil) {
//                                            self.recordFiles.append(url!)
//                                        }
//
                                        
                                        isRecording = false
                                        
                                    } else {
    //                                    self.recordController.startRecording{ error in
    //                                        if let error = error {
    //                                            print(error.localizedDescription)
    //                                            return
    //                                        }
    //
    //                                        isRecording = true
    //                                    }
                                        
                                        
//                                        AudioEngineController.sharedInstance.record()
                                        
                                        isRecording = true

                                    }
                                }) {
                                    
                                    Image(systemName: isRecording ? "record.circle.fill" : "record.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .font(.title)
                                        .offset(y: 20)
                                        .padding(.leading, 10)
                                        .foregroundColor(isRecording ? .red : .blue)
                                    
                                    
                                    
                                }
                            }
                            
                            
                            
                        }
                    
                    } // ToolbarItem
                    
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button( action: {
                            print("right button")
                            if(showLeftMenu == false) {
                                self.showRightMenu.toggle()
                            } else {
                                print("socket connected")
                                self.selectRoomCheck = false
                            }
                        }) {
                            if showLeftMenu == false {
                                if showRightMenu {
                                    Image(systemName: "arrowshape.turn.up.backward.2.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .font(.title)
                                        .offset(y: 20)
                                } else {
                                    Image(systemName: "message.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .font(.title)
                                        .offset(y: 20)
                                }
                                
                            } else {
                                Image(systemName: "arrowshape.turn.up.backward.2.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .font(.title)
                                    .offset(y: 20)
                            }
                            
                        }

                    } // ToolbarItem
                    
                } // toolbar
                
                

                
//            } // NavigationView
//            .navigationViewStyle(StackNavigationViewStyle())
//            .ignoresSafeArea(.keyboard, edges: .bottom)
//            .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
            
            
        } else { // iPhone View
            
//            NavigationView {
                ZStack {
                    VStack{
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                            
                            TabView(selection: $selectedTab) {
                                DrumView(dcDic: dcDic)
                                    .tag("drum")
                                    .offset(y:-40)


                                PianoView(pcDic: pcDic, dcDic: dcDic)
                                    .tag("piano_button")
                                    .offset(y:-40)

                                GuitarView()
                                    .tag("guitar")
                                    .offset(y:-40)

                                RecordView(recordFiles: $recordFiles)
                                    .tag("rec")
                                    .offset(y:-40)

                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .ignoresSafeArea(.all, edges: .bottom)
                            
                            
                            
                            
                            HStack(spacing: 0) {
                                ForEach(instrument, id: \.self) { image in
                                    InstrumentButton(image: image, selectedTab: $selectedTab)
                                    
                                    if image != instrument.last {
                                        Spacer(minLength: 0)
                                    }
                                }
                            }
                            .padding(.horizontal, 25)
                            .padding(.vertical, 5)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x:5, y: 5)
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
                            .padding(.horizontal)
                            .padding(.bottom, edge!.bottom == 0 ? 20: 0)
                            
                            
                            
                            
                        }  // ZStack
                        
                        Spacer()
                        
                        
                    } // VStack
                    
                    
                    
                    LeftBarView(userArray: userArray, nameDic: nameDic)
                        .offset(x: showLeftMenu ? 0 : -(width))
                        .background(Color.black.opacity(showLeftMenu ? 0.5 : 0).ignoresSafeArea(.all))
                    
                    
                } // ZStack
            
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {


                        Button( action: {
                            print("left button")
                            withAnimation(.spring()){self.showLeftMenu.toggle()}
                            

                        }) {
                            HStack {
                                if showRightMenu == false {
                                    if showLeftMenu {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .font(.title)
                                            .offset(y: 20)
                                    } else {
                                        Image(systemName: "speaker.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .font(.title)
                                            .offset(y: 20)
                                    }
                                }

                                Button( action: {
                                    if isRecording {

    //                                    Task {
    //                                        do {
    //                                            let url = try await self.recordController.stopRecording()
    //                                            self.recordFiles.append(url)
    //                                            isRecording = false
    //
    //
    //                                        } catch {
    //                                            print(error.localizedDescription)
    //                                        }
    //                                    }
//                                        let url: URL? = AudioEngineController.sharedInstance.stop()
//
//                                        if(url != nil) {
//                                            self.recordFiles.append(url!)
//                                        }
//                                        self.recordController.stop()
//                                        AudioEngineController.sharedInstance.stop()
                                        isRecording = false

                                    } else {
    //                                    self.recordController.startRecording{ error in
    //                                        if let error = error {
    //                                            print(error.localizedDescription)
    //                                            return
    //                                        }
    //
    //                                        isRecording = true
    //                                    }


//                                        AudioEngineController.sharedInstance.record()
                                        
//                                        AudioEngineController.sharedInstance.record()
                                        isRecording = true

                                    }
                                }) {

                                    Image(systemName: isRecording ? "record.circle.fill" : "record.circle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .font(.title)
                                        .offset(y: 20)
                                        .padding(.leading, 10)
                                        .foregroundColor(isRecording ? .red : .blue)



                                }
                            }



                        }

                    } // ToolbarItem
                
                    
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button( action: {
                            print("right button")
                            if(showLeftMenu == false) {
                                self.showRightMenu.toggle()
                            } else {

                                self.selectRoomCheck = false
                            }
                        }) {
                            if showLeftMenu == false {
                                if showRightMenu {
                                    Image(systemName: "arrowshape.turn.up.backward.2.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .font(.title)
                                        .offset(y: 20)
                                } else {
                                    Image(systemName: "message.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .font(.title)
                                        .offset(y: 20)
                                }

                            } else {
                                Image(systemName: "arrowshape.turn.up.backward.2.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .font(.title)
                                    .offset(y: 20)
                            }

                        }

                    } // ToolbarItem

                } // toolbar
                
                

                
//            } // NavigationView
//            .ignoresSafeArea(.keyboard, edges: .bottom)
//            .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
            }
        }
        



struct InstrumentButton: View {
    var image: String

    @Binding var selectedTab: String

    var body: some View {
        Button(action: {
            selectedTab = image
            print(selectedTab)
        }) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 24, height: 24)
                .foregroundColor(selectedTab == image ? Color.gray: Color.black)
                .padding()

        }
    }
}
}
