import AVFoundation
import Foundation

class DrumsControllerAudioKit {
    
    var player: AVAudioPlayer?
    
    init() {
        
        do {
            
            let url = Bundle.main.path(forResource: "cr", ofType: "wav")
            
            self.player = try AVAudioPlayer(contentsOf: URL(string: url!)!)
            
        } catch {
            print("error")
        }
        
    }
    
    func play() {
        player!.play()
    }
    
    
}
