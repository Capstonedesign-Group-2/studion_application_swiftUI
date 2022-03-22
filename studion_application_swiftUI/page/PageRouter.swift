//
//  PageRouter.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/21.
//

import SwiftUI

struct PageRouter: View {
    @State var pageStatus: String = "/splashScreen"
    
    var body: some View {
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
            case "/register":
                RegisterView(pageStatus: $pageStatus)
                    .onAppear{ print("/register start") }
                    .onDisappear{ print("/register end") }
                
            case "/" :
                MainView(pageStatus: $pageStatus)
                    .onAppear{ print("/ start") }
                    .onDisappear{ print("/ end") }
                
            default :
                SplashScreen(pageStatus: $pageStatus)
            }
        }
    }
}

struct PageRouter_Previews: PreviewProvider {
    static var previews: some View {
        PageRouter()
    }
}
