//
//  WaveView2.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/05/06.
//

import SwiftUI
import Waveform
import AVFoundation
import mobileffmpeg

struct WaveView2: View {
    @Binding var isEdit: Bool
    
    @State var width: CGFloat = -10
    @State var width1: CGFloat = 622
    
    @State var generator = WaveformGenerator(audioFile: try! AVAudioFile(forReading: RecordController.sharedInstance.getUrl()))!
    @State var selectedSamples = 0..<1
    
    @State var sliderPosition: ClosedRange<Float> = 0...1
    
    
    @State var playTimer = 0.0
    @State var player: AVAudioPlayer!
    @State var duration = 0.0
    @State var endTime = 0.0
    @State var isPlaying = false
    @State var endWidth = 0.0
    @State var timerWidth = 0.0
    @State var isStart = false
    
    @State var isPost = false
    @State var content = ""
    @State var hintText: String = "This is input form"
    
    
    @State var startPointEditer = 0.0
    @State var endPointEditoer = 0.0
    @State var sendURL: URL?
    
    var roomUser: [Any]
    
    @State var roomUserArray: [Any] = []
    
    var body: some View {
        
        NavigationView {
            
            VStack {
            
            if !isPost {
                VStack {
                   
                    Waveform(generator: generator, selectedSamples: $selectedSamples, selectionEnabled: .constant(false))
                        .layoutPriority(1)
                        .foregroundColor(Color.green)
                        .background(Color.clear)
                        .accentColor(Color.green)
                        .frame(width: 650, height: 200)
                    
                    RangeSlider(width: self.$width, width1: self.$width1, endWidth: self.$endWidth)
                    
                    HStack {
                        
                        Button( action: {
                            if(!self.player.isPlaying) {
                                print("play")
    //                            self.player.play(atTime: playTime)
                                self.endWidth = 0.0
                                
                                let end = 688 - (622 - self.width1)
    //                            print("end : \(end)")
                                let start = 38 + (self.width + 10)
                                let timePercent = (self.width + 10) / 650
                                var startTime = self.duration * timePercent
                                
                                if(startTime == 0.0) {
                                    startTime = 0.01
                                }
                                
                                self.player.currentTime = startTime
                                
                                let endTimePercent = (650 - (622 - self.width1)) / 650
                                self.endTime = self.duration * endTimePercent
                                
                                let playWidth = (688 - (622 - self.width1)) - (38 + (self.width + 10))
    //                            let playPercent = playWidth / 650
    //                            print("playPercent : \(playPercent)")
                                
                                let playTime = self.endTime - startTime
    //                            print("playTime : \(playTime)")
                                self.timerWidth = playWidth / (playTime * 100)
                                
                                self.player.play()
                                
                                self.isPlaying = true
                            } else {
                                print("playing")
                            }
                        } ) {
                            Text("play")
                        }
                        
                        Button( action : {
                            if(self.player.isPlaying) {
                                print("stop")
    //                            self.playTime = self.player.currentTime
                                self.player.stop()
                                
                                self.isPlaying = false
                                self.endWidth = 0.0
                            } else {
                                print("stopping")
                            }
                        }) {
                            Text("stop")
                        }
                        
                        Button( action: {
                            print("save")
                        }) {
                            Text("local save")
                        }
                        
                        Button( action: {
                            print("post save")
                            
                            timeEdite()
                            
                            
                            
                            isPost.toggle()
                            
                        }) {
                            Text("post save")
                        }
                        
                    } // HStack
                    
                    Button( action: {
                            self.isEdit.toggle()
                        }) {
                            Text("end")
                        }
                        .onAppear{
                            print("recording view")
                        }
                    
                }   // VStack
                .frame(maxWidth: .infinity, maxHeight:.infinity, alignment: .center)
                
                .offset(y: 50)
                
                Path { path in
                    path.move(to: CGPoint(x:38 + (self.width + 10), y: 0))
                    path.addLine(to: CGPoint(x: 38 + (self.width + 10), y: 210))
                    path.addLine(to: CGPoint(x: 688 - (622 - self.width1) + 10, y: 210))
                    path.addLine(to: CGPoint(x:688 - (622 - self.width1) + 10, y:0))
                    path.closeSubpath()
                }
                .fill(Color.green)
                .opacity(0.1)
                .offset(y: -240)
                
                Path { path in
                    path.move(to: CGPoint(x:38 + (self.width + 10), y: 0))
                    path.addLine(to: CGPoint(x: 38 + (self.width + 10), y: 210))
                    
                    
                    path.addLine(to: CGPoint(x: 38 + (self.width + 10) + self.endWidth, y: 210))
                    path.addLine(to: CGPoint(x: 38 + (self.width + 10) + self.endWidth, y:0))
                    path.closeSubpath()
                }
                .fill(Color.blue)
                .opacity(0.1)
                .offset(y: -270)
                
                
            } else {
                
                
                HStack {
                    Text("Composers")
                        .font(.title).fontWeight(.bold)
                        .foregroundColor(Color("mainColor3"))
                        .padding()
                    
                    Spacer()
                    
                    ForEach(0..<roomUserArray.count, id: \.self) { index in
                        
                        let userInfo = roomUserArray[index] as! Dictionary<String, Any>
                        let user = userInfo["user"] as! Dictionary<String, Any>
                        
                        
                        Circle()
                            .fill(Color("mainDark2"))
                            .frame(width: 60, height: 60)
                            .padding()
                            .background(Circle().stroke(Color.white, lineWidth: 5))
                            .overlay(
                                Text(user["name"] as! String)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                    .foregroundColor(Color(red: 252/255, green: 246/255, blue: 245/255))
//                                    .rotationEffect(.degrees(90.0))
                            )
                            .clipped()
                    }
                }
                
                Spacer()
                
                Form {
                    Section(header: Text("Simple Upload")){
                        ZStack{
                            if content.isEmpty {
                                Text(hintText)
                                    .foregroundColor(Color(UIColor.placeholderText))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 12)
                            }
                            TextEditor(text: $content)
                                .frame(height: 600, alignment: .center)
                        }
                        
                                                        
                        
                        Button( action: {
                            if(checkText(content: content)){
                                self.hintText = "무언가를 입력해주세요....."
                            }
                            upload() { data in
                                
                            }
                            
                            self.isPost = false
                        }) {
                            Text("업로드")
                                .foregroundColor(Color("mainColor2"))
                        }
                        Button( action: {
                            self.isPost = false
                        }) {
                            Text("뒤로가기")
                                .foregroundColor(Color.red.opacity(0.5))
                        }
                    }

                } // form
            
            }
        }   //vS
            .frame(maxWidth: .infinity, maxHeight:.infinity, alignment: .center)
            .navigationTitle("Recording Relay")
            .navigationBarTitleDisplayMode(.inline)
    }// Nav
        
        .onAppear{
            selectedSamples = 0..<Int(generator.audioBuffer.frameLength)
            do {
                self.player = try AVAudioPlayer(contentsOf: RecordController.sharedInstance.getUrl())
//                    self.player.prepareToPlay()
            } catch {
                print(error.localizedDescription)
            }
            self.duration = self.player.duration
            
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (_) in
//                    print(RecordController.sharedInstance.getUrl())
                if(self.isPlaying) {
                    print("------------------------------")
                    print("self.player.currentTime : \(self.player.currentTime)")
                    print("self.endTime : \(self.endTime)")
                                            
                    if(self.player.currentTime >= self.endTime) {
                        
                        print("over")
                        if(self.player.isPlaying) {
                            self.player.stop()
                        }
                        
                        self.isPlaying = false
                    }
                    
                    if(isStart && self.player.currentTime == 0.0) {
                        self.isStart = false
                        self.isPlaying = false
                    }
                    
                    if(!isStart && self.player.currentTime == 0.0) {
                        isStart = true
                    }
                    
                    self.endWidth += self.timerWidth
                    
                    
                } else {
//                    print("stop")
                }
            }
            
            UITextView.appearance().backgroundColor = .clear
            
//            print(roomUser[0])
//            print(roomUser.count)
            
            roomUserArray = roomUser[0] as! [Any]
            
            
            
            if(roomUserArray.count == 0) {
                
                var name:[String: String] = [
                    "name" : UserInfo.userInfo.getUserInfo()?.name as! String
                ]
                
                var user:[String: Any] = [
                    "user" : name
                ]
                
                roomUserArray.append(user)
            }
            
        
    }
}
    
    func timeEdite() {
        
        let end = 688 - (622 - self.width1)
//                            print("end : \(end)")
        let start = 38 + (self.width + 10)
        let timePercent = (self.width + 10) / 650
        self.startPointEditer = self.duration * timePercent
        
        let endTimePercent = (650 - (622 - self.width1)) / 650
        self.endPointEditoer = self.duration * endTimePercent
        
        
        let name = UUID().uuidString + ".wav"
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(name)
        
        MobileFFmpeg.execute("-i \(RecordController.sharedInstance.getUrl()) -ss \(self.startPointEditer) -t \(self.endPointEditoer) -acodec copy \(url)")
        
        self.sendURL = url
    }
        

    
    func upload(handler: @escaping (Any) -> Void) {
        do {
            var data: [String: Any] = [
                "content" : self.content,
            ]
            
            data["audio"] = try Data(contentsOf: self.sendURL!)
            data["audioURL"] = self.sendURL!
            
            var userArray: [Int] = []
            
            roomUserArray.enumerated().forEach {
                let userName = $1 as! Dictionary<String, Any>
                userArray.append(userName["user_id"] as! Int)
//                let composer = "composer[\($0)]"
//                data[composer] = userName["user_id"]
                
            }
            
//            print(data)
            data["composers"] = userArray
            
            PostController.sharedInstance.create(data: data) { data in
                var response = data as! Dictionary<String, Any>
                
                if(response["status"] as! Int == 200) {
                    print(response)
                    self.content = ""
                    handler("true")
                    
                } else {
                    print("error")
                }
                
                print(response)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
   
}
        
        func checkText(content: String) -> Bool {
            if(content == " " || content == ""){
                return true
            } else {
                return false
            }
        }

struct RangeSlider: View {
    
//    @State var width : CGFloat = 0
//    @State var width1: CGFloat = 622
    
    @Binding var width: CGFloat
    @Binding var width1: CGFloat
    @Binding var endWidth: Double
    
    var body: some View {
        VStack {
            ZStack (alignment: .leading){
                Rectangle()
                    .fill(Color.black.opacity(0.20))
                    .frame(width: 650 ,height: 6)
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: self.width1 - self.width + 30, height: 6)
                    .offset(x: self.width)
                
                HStack (spacing: 0){
                    Circle()
                        .fill(Color.green)
                        .frame(width: 25, height: 25)
                        .offset(x: self.width)
                        .gesture(
                            DragGesture()
                                .onChanged({ (value) in
                                    
                                    if(value.location.x >= 0 && value.location.x <= self.width1) {
                                        self.width = value.location.x
                                        print("width : \(self.width)")
                                        self.endWidth = 0.0
                                        
                                        
                                    }
                                })
                        )
                    
                    Circle()
                        .fill(Color.green)
                        .frame(width: 25, height: 25)
                        .offset(x: self.width1)
                        .gesture(
                            DragGesture()
                                .onChanged({ (value) in
                                    
                                    if(value.location.x <= 622 && value.location.x >= self.width) {
                                        self.width1 = value.location.x

                                        print("width1 : \(self.width1)")
                                        self.endWidth = 0.0
                                    }
                                })
                        )
                    
                }   // HStack
            }   // ZStack
        }   // VStack
    }
}

