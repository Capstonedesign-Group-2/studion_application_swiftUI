//
//  RegisterView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/21.
//

import SwiftUI

let registerLightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)

struct RegisterView: View {
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConfrim: String = ""
    
    @State var loginStatus: Bool = false
    @State var isRegister: Bool = false
    
    @Binding var registerStatus: Bool
    
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    var body: some View {
        
        ZStack {
            VStack {
                registerTitle()
                registerForm(name: $name, email: $email, password: $password, passwordConfrim: $passwordConfrim, isRegister: $isRegister)
                Spacer()
                HStack {
                    Button(action : {
                        self.registerStatus = false
                    }) {
                        Text("로그인")
                    }
                    Text("하러가기")
                }
            }
            
            NavigationLink(destination: MainView(), isActive: $isRegister ,label: {})
                .isDetailLink(false)
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationViewStyle(.stack)
        .padding()

        
        
    }
}


struct registerTitle: View {
    var body: some View{
        Text("Studion")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct registerForm: View {
    
    @Binding var name: String
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfrim: String
    @Binding var isRegister: Bool
    
    @State var registerFail: Bool = false
    
    var body: some View{
        registerNameForm(name: $name)
        registerEmailForm(email: $email)
        registerPasswordForm(password: $password)
        registerPasswordConfrimForm(passwordConfirm: $passwordConfrim)
        
        registerButton(name: $name, email: $email, password: $password, passwordConfrim: $passwordConfrim, registerFail: $registerFail, isRegister: $isRegister)
        
    }
}

struct registerNameForm: View {
    @Binding var name: String
    
    var body: some View {
        TextField("name", text: $name)
            .padding()
            .background(registerLightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct registerEmailForm: View {
    @Binding var email: String
    
    
    var body: some View{
        TextField("E-mail", text: $email)
            .padding()
            .background(registerLightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct registerPasswordForm: View {
    @Binding var password: String
    
    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .background(registerLightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct registerPasswordConfrimForm: View {
    @Binding var passwordConfirm: String
    
    var body: some View {
        SecureField("PasswordConfrim", text: $passwordConfirm)
            .padding()
            .background(registerLightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct registerButton: View {
    
    @Binding var name: String
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfrim: String
    @Binding var registerFail: Bool
    @Binding var isRegister: Bool
    
    @State var registerErrorStatus: Bool = false
    @State var registerErrorTitle: String = ""
    @State var registerError: String = ""
    
    var body: some View {
        Button(action: {
            if (blackCheck(name: name, email: email, password: password, passwordConfrim: passwordConfrim)) {
                self.registerErrorTitle = "공백!"
                self.registerError = "어딘가에 공백이 있어요!!"
                self.registerErrorStatus = true
                
                return
            } else if (passwordCheck(password: password, passwordConfrim: passwordConfrim)) {
                self.registerErrorTitle = "비밀번호가 같지 않아요!!"
                self.registerError = "비밀번호좀 같게 해줘요!!"
                self.registerErrorStatus = true
                
                return
            }
            
            AuthController.sharedInstance.register(email: email, password: password, password_confirm: passwordConfrim, name: name) { data in
                print("authcontroller register")
                
                let register = data as! Dictionary<String, Any>
                
                if(register["status"] as! Int == 422) {
                    print(register)
                    self.registerErrorTitle = "회원가입 오류"
                    self.registerError = "이미 가입이 되어 있는 이메일 입니다."
                    self.registerErrorStatus = true
                    return
                } else if(register["status"] as! Int == 200) {
                    
                    self.isRegister = true
                    return
                }
                
                
            }
                        
            
            
        }) {
            registerButtonLayout()
        }
        .alert(registerErrorTitle, isPresented: $registerErrorStatus) {
            Button("OK") {}
        } message: {
            Text(registerError)
        }
        
    }
    
    
    func blackCheck(name: String, email: String, password: String, passwordConfrim: String ) -> Bool {
        if(name == "" || email == "" || password == "" || passwordConfrim == "") {
            return true
        }
        
        return false
    }
               
    func passwordCheck(password: String, passwordConfrim: String) -> Bool {
            if(password != passwordConfrim) {
                return true
            }
            return false
    }
}

struct registerButtonLayout: View {
    
    var body: some View {
        Text("REGSITER")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(35.0)
    }
}
