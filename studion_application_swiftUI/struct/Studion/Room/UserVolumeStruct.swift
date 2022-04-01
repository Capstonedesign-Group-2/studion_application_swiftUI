//
//  UserVolumeStruct.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/31.
//

import Foundation

public class UserVolumeStruct {
    
    struct volume: Codable {
        var socketId: String
        var volume: Double
        var masterVolume: Double
    }
}
