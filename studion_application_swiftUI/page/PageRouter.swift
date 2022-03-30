//
//  PageRouter.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/21.
//

import SwiftUI

struct PageRouter: View {
    @State var pageStatus: String = "/splashScreen"
    @State var roomNumber: Int = -1
    
    var body: some View {
//        NavigationView {
            VStack {
                switch pageStatus {
                case "/splashScreen":
                 SplashScreen(pageStatus: $pageStatus)
                        .onAppear{ print("/splashScreen start") }
                        .onDisappear{ print("/splashScreen end") }

                case "/login":
                    LoginView(pageStatus: $pageStatus)
                        .onAppear{ print("/login start") }
                        .onDisappear{ print("/login end") }
//                        .offset(y: -100)
                case "/register":
                    RegisterView(pageStatus: $pageStatus)
                        .onAppear{ print("/register start") }
                        .onDisappear{ print("/register end") }
//                        .offset(y: -100)

                case "/" :
                    MainView(pageStatus: $pageStatus, roomNumber: $roomNumber)
                        .onAppear{ print("/ start") }
                        .onDisappear{ print("/ end") }

                case "/room":
                    RoomView(pageStatus: $pageStatus, roomNumber: roomNumber)

                default :
                    SplashScreen(pageStatus: $pageStatus)
                }

            
//        } // NavigationView
        
        
    }
}
}
