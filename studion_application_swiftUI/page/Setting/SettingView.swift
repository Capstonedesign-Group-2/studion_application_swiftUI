//
//  SettingView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/22.
//

import SwiftUI

struct SettingView: View {
    @Binding var pageStatus: String
    
    @State var logoutToggle: Bool = false
    @State var logoutStatus: Bool = false
    @State var isLogout: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack {
                Button(action: {
                    self.logoutToggle = true
                }) {Text("Logout")}
            }
            .alert(isPresented: $logoutToggle) {
                Alert(title: Text("로그아웃?"), primaryButton: .destructive(Text("응!")){
                    self.logout() {data in
                        if(data as! Bool == true) {
                            print("zz")
    //                        self.pageStatus = "/login"
                            self.isLogout = true
                        } else {
                            self.logoutStatus = true
                        }
                    }
                }, secondaryButton: .cancel(Text("아뇨?")) {})
            }
            .alert("로그아웃 오류!", isPresented: $logoutStatus) {
                Button("응") {}
            } message : {
                Text("조금 있다 다시")
            }
            
            NavigationLink(destination: LoginView(), isActive: $isLogout, label: {})
        }   //  ZStack
        
            
    }
    
    func logout(handler: @escaping (Any) -> Void) {
        AuthController.sharedInstance.logout() {data in
            let logout = data as! Dictionary<String, Any>
            
            if(logout["status"] as! Int == 200) {
                print("logout success")
                handler(true)
            } else {
                print("logout false")
                handler(false)
            }
        }
    }
}

