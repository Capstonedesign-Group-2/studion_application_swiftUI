
import SwiftUI
import AVFoundation

// swiftlint:disable:next type_body_length
class DrumsController: NSObject, ObservableObject {

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
  func setting(key: String) {
      setupAudio(key: key)
    setupDisplayLink()
  }

  func playOrPause() {

      player.play()
  }

  func skip(forwards: Bool) {
    let timeToSeek: Double

    if forwards {
      timeToSeek = 10
    } else {
      timeToSeek = -10
    }

    seek(to: timeToSeek)
  }

  // MARK: - Private

    private func setupAudio(key: String) {
        
        var fileURL: URL?
        switch key {
        case "Q" :
            fileURL = Bundle.main.url(forResource: "cr", withExtension: "wav")
            break
        case "W":
            fileURL = Bundle.main.url(forResource: "hi", withExtension: "wav")
            break
            
        default:
            return
        }

    do {
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
//    engine.attach(timeEffect)

    engine.connect(
      player,
      to: engine.outputNode,
      format: format)
    

    engine.prepare()
    
    print(1)

    do {
      try engine.start()

      scheduleAudioFile()
    } catch {
      print("Error starting the player: \(error.localizedDescription)")
    }
  }

  private func scheduleAudioFile() {
    guard
      let file = audioFile,
      needsFileScheduled
    else {
      return
    }

    needsFileScheduled = false
    seekFrame = 0

    player.scheduleFile(file, at: nil) {
      self.needsFileScheduled = true
    }
  }

  // MARK: Audio adjustments

  private func seek(to time: Double) {
    guard let audioFile = audioFile else {
      return
    }

    let offset = AVAudioFramePosition(time * audioSampleRate)
    seekFrame = currentPosition + offset
    seekFrame = max(seekFrame, 0)
    seekFrame = min(seekFrame, audioLengthSamples)
    currentPosition = seekFrame

    let wasPlaying = player.isPlaying
    player.stop()

    if currentPosition < audioLengthSamples {
      updateDisplay()
      needsFileScheduled = false

      let frameCount = AVAudioFrameCount(audioLengthSamples - seekFrame)
      player.scheduleSegment(
        audioFile,
        startingFrame: seekFrame,
        frameCount: frameCount,
        at: nil
      ) {
        self.needsFileScheduled = true
      }

      if wasPlaying {
        player.play()
      }
    }
  }

  // MARK: Audio metering

  private func scaledPower(power: Float) -> Float {
    guard power.isFinite else {
      return 0.0
    }

    let minDb: Float = -80

    if power < minDb {
      return 0.0
    } else if power >= 1.0 {
      return 1.0
    } else {
      return (abs(minDb) - abs(power)) / abs(minDb)
    }
  }

  private func connectVolumeTap() {
    let format = engine.mainMixerNode.outputFormat(forBus: 0)

    engine.mainMixerNode.installTap(
      onBus: 0,
      bufferSize: 1024,
      format: format
    ) { buffer, _ in
      guard let channelData = buffer.floatChannelData else {
        return
      }

      let channelDataValue = channelData.pointee
      let channelDataValueArray = stride(
        from: 0,
        to: Int(buffer.frameLength),
        by: buffer.stride)
        .map { channelDataValue[$0] }

      let rms = sqrt(channelDataValueArray.map {
        return $0 * $0
      }
      .reduce(0, +) / Float(buffer.frameLength))

      let avgPower = 20 * log10(rms)
      let meterLevel = self.scaledPower(power: avgPower)


    }
  }

  private func disconnectVolumeTap() {
    engine.mainMixerNode.removeTap(onBus: 0)
  }


  private func setupDisplayLink() {
    displayLink = CADisplayLink(
      target: self,
      selector: #selector(updateDisplay))
    displayLink?.add(to: .current, forMode: .default)
    displayLink?.isPaused = true
  }

  @objc private func updateDisplay() {
    currentPosition = currentFrame + seekFrame
    currentPosition = max(currentPosition, 0)
    currentPosition = min(currentPosition, audioLengthSamples)

    if currentPosition >= audioLengthSamples {
      player.stop()

      seekFrame = 0
      currentPosition = 0

      displayLink?.isPaused = true

      disconnectVolumeTap()
    }
  }
}
