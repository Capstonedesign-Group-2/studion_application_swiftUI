//
//  VolumeController.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/04/02.
//

import Foundation

class VolumeController {
    static let sharedInstance = VolumeController()
    
    var volumeDic: [String: UserVolumeStruct.volume] = ["me" : UserVolumeStruct.volume(socketId: "me", volume: 0.8, masterVolume: 0.8)]
    
    func setVolumeDic(socketID: String) {
        volumeDic[socketID] = UserVolumeStruct.volume(socketId: socketID, volume: 0.8, masterVolume: 0.8)
    }
    
    func setVolume(socketID: String, volume: Double) {
        if(volumeDic[socketID] == nil) {
            return
        }
        
        print("setVolume : \(socketID)")
        
        volumeDic[socketID]?.volume = volume
    
    }
    
    func setMasterVolume(masterVolume: Double) {
        for key in volumeDic.keys {
            volumeDic[key]?.masterVolume = masterVolume
        }
    }
    
    func removeVolumeSetting(socketID: String) {
        volumeDic.removeValue(forKey: socketID)
    }
    
    func getMyVolume() -> UserVolumeStruct.volume{
        return volumeDic["me"]!
    }
    
    func getVolume(socketID: String) -> UserVolumeStruct.volume {
        return volumeDic[socketID]!
    }
    
    func getUser() -> Any {
        return volumeDic.keys
    }
    
}
