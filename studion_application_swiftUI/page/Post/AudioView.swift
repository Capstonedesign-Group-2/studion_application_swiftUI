//
//  AudioView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/04/15.
//

import SwiftUI
import AVKit

struct AudioView : View {
    
    @State var audioURL: String?
    @State var width: CGFloat = 0
    @State var player: AVAudioPlayer!
    @State var playing: Bool = false
    

    
    var body: some View {
        
        VStack(spacing: 20) {
//            Text(self.audioTitle).font(.title)
            
            ZStack(alignment: .leading) {
                
                Capsule().fill(Color.black.opacity(0.08)).frame(height: 8, alignment: .center)
                Capsule().fill(Color.green).frame(width: self.width, height: 8, alignment: .center)

            }.padding(.top)
            
            HStack(spacing: UIScreen.main.bounds.width / 5 - 30) {
                
                Button(action: {
                    
                    let increase = self.player.currentTime + 15
                    
                    if increase < self.player.duration {
                        self.player.currentTime = increase
                    }
                    
                    
                    }, label: {
                        Image(systemName: "goward.15.fill").font(.title)
                    }
                )
                
                Button(action: {
                    if self.player.isPlaying {
                        
                        self.player?.pause()
                        self.playing = false
                        
                    } else {
                        
                        self.player?.play()
                        self.playing = true

                    }
                    }, label: {
                        Image(systemName: self.playing ? "pause.fill" : "play.fill").font(.title)
                    }
                )
                
                Button(action: {
                    
                    self.player.currentTime -= 15
                    
                    }, label: {
                        Image(systemName: "backward.15.fill").font(.title)
                    }
                )
                
                
                
            } // hS
            .padding(.top, 25)
            .foregroundColor(Color.black)
            
            
            
            .task {
                
                let url = Bundle.main.path(forResource: self.audioURL, ofType: "mp3, wav")
                
//                self.player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath:  audioURL!))
                
                self.player.prepareToPlay()
                self.getAudioData()
                
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                    
                    if self.player.isPlaying {
    //                    print(self.player.currentTime) // time
                        let screen = UIScreen.main.bounds.width - 30
                        
                        let value = self.player.currentTime / self.player.duration
                        
                        self.width = screen * CGFloat(value)
                    }
                }
            }
                
        } // vS
    }
    func getAudioData() {

        let asset = AVAsset(url: self.player.url!)
        
    }
}



struct AudioView_Previews: PreviewProvider {
    static var previews: some View {
        AudioView()
    }
}
