////
////  DrumsController.swift
////  studion_application_swiftUI
////
////  Created by 김진홍 on 2022/03/25.
////
//
//import Foundation
//import AVFoundation
//
//class DrumsController {
//
////    var drumKey: [String: URL] = [:]
//
//    var url: URL?
//    var audioEngine = AVAudioEngine()
//    var playerNode = AVAudioPlayerNode()
//
//    init(key: String) {
//        drumSettings(key: key)
//    }
//
//    func drumSettings(key: String) {
//
//        switch key {
//        case "Q" :
//            url = Bundle.main.url(forResource: "cr", withExtension: "wav")!
//            break
//        case "W":
//            url = Bundle.main.url(forResource: "hi", withExtension: "wav")!
//            break
//        case "E":
//            url = Bundle.main.url(forResource: "rS", withExtension: "wav")!
//            break
//        case "A":
//            url = Bundle.main.url(forResource: "tom3", withExtension: "wav")!
//            break
//        case "S":
//            url = Bundle.main.url(forResource: "tom2", withExtension: "wav")!
//            break
//        case "D":
//            url = Bundle.main.url(forResource: "tom1", withExtension: "wav")!
//            break
//        case "Z":
//            url = Bundle.main.url(forResource: "snst", withExtension: "wav")!
//            break
//        case "X":
//            url = Bundle.main.url(forResource: "ki", withExtension: "wav")!
//            break
//        case "C":
//            url = Bundle.main.url(forResource: "sn", withExtension: "wav")!
//            break
//        default:
//            url = nil
//            break
//        }
//
//
//    }
//
////    func drumPlay(key: String, socketId: String, handler: @escaping (Any) -> Void) {
////        do {
////            let audioFile: AVAudioFile?
////
////            switch key {
////            case "Q":
////                audioFile = try AVAudioFile(forReading: drumKey[key]!)
////                break
////            case "W":
////                audioFile = try AVAudioFile(forReading: drumKey[key]!)
////                break
////            case "E":
////                audioFile = try AVAudioFile(forReading: drumKey[key]!)
////                break
////            case "A":
////                audioFile = try AVAudioFile(forReading: drumKey[key]!)
////                break
////            case "S":
////                audioFile = try AVAudioFile(forReading: drumKey[key]!)
////                break
////            case "D":
////                audioFile = try AVAudioFile(forReading: drumKey[key]!)
////                break
////            case "Z":
////                audioFile = try AVAudioFile(forReading: drumKey[key]!)
////                break
////            case "X":
////                audioFile = try AVAudioFile(forReading: drumKey[key]!)
////                break
////            case "C":
////                audioFile = try AVAudioFile(forReading: drumKey[key]!)
////                break
////
////
////            default:
////                return
////            }
////            audioEngine.attach(playerNode)
////
////            audioEngine.connect(playerNode, to: audioEngine.outputNode, format: audioFile!.processingFormat)
////
////            playerNode.scheduleFile(audioFile!, at: nil, completionCallbackType: .dataPlayedBack, completionHandler: {_ in
////                handler("end")
////            })
////
////            try audioEngine.start()
////            playerNode.play()
////        } catch {
////            print("error")
////        }
////    }
//
//
//    func drumPlay_my(handler: @escaping (Any) -> Void) {
//        do {
//            if(url == nil) {
//                return
//            }
//
//            print("connect")
//
//            let audioFile: AVAudioFile = try AVAudioFile(forReading: url!)
//
//            audioEngine.attach(playerNode)
//
//            audioEngine.connect(playerNode, to: audioEngine.outputNode, format: audioFile.processingFormat)
//
//            playerNode.scheduleFile(audioFile, at: nil, completionHandler: {
//                handler("end")
//            })
//
//            try audioEngine.start()
//            playerNode.play()
//
//        } catch {
//            print("error")
//        }
//    }
//
//
//}
//
//
//
//


/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import AVFoundation

// swiftlint:disable:next type_body_length
class DrumsController: NSObject, ObservableObject {
  // MARK: Public properties

  var isPlaying = false {
    willSet {
      withAnimation {
        objectWillChange.send()
      }
    }
  }
  var isPlayerReady = false {
    willSet {
      objectWillChange.send()
    }
  }
  
 
  var playerProgress: Double = 0 {
    willSet {
      objectWillChange.send()
    }
  }
  var meterLevel: Float = 0 {
    willSet {
      objectWillChange.send()
    }
  }

  // MARK: Private properties

  private let engine = AVAudioEngine()
  private let player = AVAudioPlayerNode()
  private let timeEffect = AVAudioUnitTimePitch()

  private var displayLink: CADisplayLink?

  private var needsFileScheduled = true

  private var audioFile: AVAudioFile?
  private var audioSampleRate: Double = 0
  private var audioLengthSeconds: Double = 0

  private var seekFrame: AVAudioFramePosition = 0
  private var currentPosition: AVAudioFramePosition = 0
  private var audioLengthSamples: AVAudioFramePosition = 0

  private var currentFrame: AVAudioFramePosition {
    guard
      let lastRenderTime = player.lastRenderTime,
      let playerTime = player.playerTime(forNodeTime: lastRenderTime)
    else {
      return 0
    }

    return playerTime.sampleTime
  }

  // MARK: - Public

  override init() {
    super.init()

//    setupAudio()
  }

  func playOrPause() {
      player.play()
    
  }

  // MARK: - Private

    func setupAudio(key: String) {
        var fileURL: URL?
        
    do {
        switch key {
        case "Q":
            fileURL = Bundle.main.url(forResource: "cr", withExtension: "wav")
            break
        case "W":
            fileURL = Bundle.main.url(forResource: "hi", withExtension: "wav")
            break
            
        default:
            fileURL = nil
        }
        
        if(fileURL == nil) {
            return
        }
      let file = try AVAudioFile(forReading: fileURL!)
      let format = file.processingFormat

      

      audioFile = file

      configureEngine(with: format)
    } catch {
      print("Error reading the audio file: \(error.localizedDescription)")
    }
  }

  private func configureEngine(with format: AVAudioFormat) {
    engine.attach(player)
    engine.attach(timeEffect)

    engine.connect(
      player,
      to: engine.outputNode,
      format: format)
    
    print(1)

    do {
      try engine.start()

      scheduleAudioFile()
    } catch {
      print("Error starting the player: \(error.localizedDescription)")
    }
  }

  private func scheduleAudioFile() {

    player.scheduleFile(audioFile!, at: nil) {
      self.needsFileScheduled = true
    }
  }

  // MARK: Audio metering

//  private func scaledPower(power: Float) -> Float {
//    guard power.isFinite else {
//      return 0.0
//    }
//
//    let minDb: Float = -80
//
//    if power < minDb {
//      return 0.0
//    } else if power >= 1.0 {
//      return 1.0
//    } else {
//      return (abs(minDb) - abs(power)) / abs(minDb)
//    }
//  }

//  private func connectVolumeTap() {
//    let format = engine.mainMixerNode.outputFormat(forBus: 0)
//
//    engine.mainMixerNode.installTap(
//      onBus: 0,
//      bufferSize: 1024,
//      format: format
//    ) { buffer, _ in
//      guard let channelData = buffer.floatChannelData else {
//        return
//      }
//
//      let channelDataValue = channelData.pointee
//      let channelDataValueArray = stride(
//        from: 0,
//        to: Int(buffer.frameLength),
//        by: buffer.stride)
//        .map { channelDataValue[$0] }
//
//      let rms = sqrt(channelDataValueArray.map {
//        return $0 * $0
//      }
//      .reduce(0, +) / Float(buffer.frameLength))
//
//      let avgPower = 20 * log10(rms)
//      let meterLevel = self.scaledPower(power: avgPower)
//
//      DispatchQueue.main.async {
//        self.meterLevel = self.isPlaying ? meterLevel : 0
//      }
//    }
//  }
//
//  private func disconnectVolumeTap() {
//    engine.mainMixerNode.removeTap(onBus: 0)
//    meterLevel = 0
//  }



}
