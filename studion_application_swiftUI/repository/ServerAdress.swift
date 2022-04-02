//
//  ServerAdress.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/23.
//

import Foundation

public class ServerAdress {
    static let sharedInstance = ServerAdress()
    
//    let api: String = "http://172.21.2.52"
    let api: String = "http://192.168.1.4"
//    let api: String = "http://172.20.10.3"
//    let api: String = "http://172.21.2.201"
//    let api: String = "http://192.168.0.78"
//    let api: String = "http://192.168.38.71"
//    let api: String = "https://api.liveroom.shop/"
    
    
    func getApiServerAdress() -> String {
        return api + ":8000/"
    }
    
    func getSocketServerAdress() -> String {
//        return api + ":5000/"
        return api + ":9876/"
    }
    
    
}
