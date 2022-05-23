//
//  Login.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/21.
//

import SwiftUI


let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)

struct LoginView: View {
//    @Binding var pageStatus: String
    
    
    @State var registerStatus: Bool = false
    @State var isLogin: Bool = false
    @State var isRegister: Bool = false
    
    @State var email: String = ""
    @State var password: String = ""
    
    
    var body: some View {
        
        
        if UIDevice.isIpad {
            
            ZStack {
                VStack {
//                    Title()
                    Spacer()
                    BannerImage()
                    Spacer()
                    loginForm(email: $email, password: $password, isLogin: $isLogin)
                    Spacer()
                    HStack {
                        Button(action : {
                            self.registerStatus = true
                        }) {
                            Text("회원가입")
                        }
                        Text("하러가기")
                    }
                }
                .frame(width: 500, alignment: .center)
                
                NavigationLink(destination: RegisterView(registerStatus: $registerStatus, isRegister: $isRegister, isLogin: $isLogin), isActive: $registerStatus, label: {})
                    .isDetailLink(false)
                NavigationLink(destination: MainView(), isActive: $isLogin ,label: {})
                    .isDetailLink(false)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationViewStyle(.stack)
            .padding()
            
        } else {
            
            ZStack {
                VStack {
//                    Title()
                    Spacer()
                    BannerImage()
                    Spacer()
                    loginForm(email: $email, password: $password, isLogin: $isLogin)
                    Spacer()
                    HStack {
                        Button(action : {
                            self.registerStatus = true
                        }) {
                            Text("회원가입")
                        }
                        Text("하러가기")
                    }
                }
                
                NavigationLink(destination: RegisterView(registerStatus: $registerStatus, isRegister: $isRegister, isLogin: $isLogin), isActive: $registerStatus, label: {})
                    .isDetailLink(false)
                NavigationLink(destination: MainView(), isActive: $isLogin ,label: {})
                    .isDetailLink(false)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationViewStyle(.stack)
            .padding()
            
        }
        
    }
    
    
    
    
    
    
}


struct Title: View {
    var body: some View{
        Text("Studion")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct BannerImage: View {
    var body: some View {
        Image("Studion-original")
            .padding(.bottom, 20)
    }
}

struct loginForm: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var isLogin: Bool
    
    @State var loginFail: Bool = false
    
    var body: some View{
        emailForm(email: $email)
        passwordForm(password: $password)
        
        Text(loginFail ? "아이디나 비밀번호가 잘못 되었습니다." : "")
            .offset(y: -10)
            .foregroundColor(.red)
            .font(.system(size:15))
        loginButton(email: $email, password: $password, loginFail: $loginFail, isLogin: $isLogin)
        
    }
}

struct emailForm: View {
    @Binding var email: String
    
    
    var body: some View{
        TextField("E-mail", text: $email)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(15.0)
            .padding(.bottom, 20)
    }
}

struct passwordForm: View {
    @Binding var password: String
    
    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(15.0)
            .padding(.bottom, 20)
    }
}

struct loginButton: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var loginFail: Bool
    @Binding var isLogin: Bool
    
    var body: some View {
        Button(action: {
//            login(email: email, password: password, loginFail: loginFail)
            print("email : \(email)")
            print("password: \(password)")
            print("loginFail: \(loginFail)")
            self.login(email: self.email, password: self.password) {data in
                if(data as! Bool == true) {
//                    self.pageStatus = "/"
                    
                    self.isLogin = true
                    
                } else {
                    self.loginFail = true
                }
            }
            }) {
            loginButtonLayout()
        }
    }
    
    func login(email: String, password: String, handler: @escaping (Any) -> Void) {
        AuthController.sharedInstance.login(email: email, password: password) {data in
            let response = data as! Dictionary<String, Any>
            if(response["status"] as! Int == 200) {
                AuthController.sharedInstance.loginCheck() {data in
                    handler(true)
                }
            } else {
                handler(false)
            }
        }
    }
}

struct loginButtonLayout: View {
    
    var body: some View {
        Text("Sign in")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 250, height: 60)
            .background(Color("mainColor3"))
            .cornerRadius(16.0)
    }
}
