//
//  MainView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/22.
//

import SwiftUI

struct MainView: View {
    @Binding var pageStatus: String
    
    @State var mainRouter: String = "/"
    
    let tabBarImageNames = ["house", "message", "plus", "rectangle.righthalf.inset.filled.arrow.right", "gearshape"]
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    @State var currentPage: Int = 0
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $mainRouter) {
                PostView()
                    .tag("/")
                
                ChatRoomList()
                    .tag("/chat")
              
                PostView()
                    .tag("/post/create")
                
                StudionRoomList(mainRouter: $mainRouter)
                    .tag("/studion")
                
                SettingView(pageStatus: $pageStatus)
                    .tag("/setting")
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            
            HStack(spacing: 0) {
//                ForEach(tabBarImageNames, id: \.self) { image in
                ForEach(0..<tabBarImageNames.count) { index in
                    TabButton(index: index, tabBarImageNames: tabBarImageNames, mainRouter: $mainRouter, currentPage: $currentPage)
                    
                    if tabBarImageNames[index] != tabBarImageNames.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.15), radius: 5, x:5, y:5)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x:5, y:5)
            .padding(.horizontal)
            .padding(.bottom, edge!.bottom == 0 ? 20: 0)
            
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
        
        
//        VStack {
//
//            HStack (spacing: 12){
//                Spacer()
//                    .frame(width: 20)
//                Text(titleName)
//                    .font(.largeTitle)
//                    .fontWeight(.heavy)
//
//                Spacer()
//            }
//            Divider()
//                .padding(.bottom, 12)
//
//            ScrollView {
//                switch mainRouter {
//                case "/" :
//                    PostView()
//                        .onAppear{ print("/ start")}
//                        .onDisappear{ print("/ end")}
//                case "/chat" :
//                    ChatRoomList()
//                        .onAppear{ print("/chat start") }
//                        .onDisappear{ print("/chat end") }
//                case "/post/create" :
//                    PostView()
//                case "/studion" :
//                    StudionRoomList()
//                        .onAppear{ print("/studion start") }
//                        .onDisappear{ print("/studion end") }
//                case "/setting" :
//                    SettingView(pageStatus: $pageStatus)
//                        .onAppear{ print("/setting start") }
//                        .onDisappear{ print("/setting end") }
//                default:
//                    PostView()
//                }
//
//            }
//        }
//
//        Spacer()
//        Divider()
//            .padding(.bottom, 12)
//        HStack {
//            ForEach(0..<5) { num in
//                Button(action: {
//                    self.selectNum = num
//                    switch self.selectNum {
//                    case 0:
//                        self.mainRouter = "/"
//                        self.titleName = "Post"
//                    case 1:
//                        self.mainRouter = "/chat"
//                        self.titleName = "Chatting"
//                    case 2:
//                        self.mainRouter = "/post/create"
//                        self.titleName = "Create"
//                    case 3:
//                        self.mainRouter = "/studion"
//                        self.titleName = "Studion"
//                    case 4:
//                        self.mainRouter = "/setting"
//                        self.titleName = "Setting"
//                    default:
//                        self.mainRouter = "/"
//                        self.titleName = "Post"
//                    }
//
//
//                } , label : {
//                    Spacer()
//                    Image(systemName: tabBarImageNames[num])
//                        .font(.system(size: 30, weight: .bold))
//                        .foregroundColor(selectNum == num ? Color(.black) : .init(white: 0.8))
//                    Spacer()
//                })
//            }
//        }
        
    }
}

struct TabButton: View {
    var index: Int
    var tabBarImageNames: [String]
    
    @Binding var mainRouter: String
    @Binding var currentPage: Int
    
    var body: some View {
        Button(action: {
            print(index)
            switch tabBarImageNames[index] {
            case "house" :
                self.mainRouter = "/"
                self.currentPage = 0
            case "message" :
                self.mainRouter = "/chat"
                self.currentPage = 1
            case "plus" :
                self.mainRouter = "/create"
                self.currentPage = 2
            case "rectangle.righthalf.inset.filled.arrow.right" :
                self.mainRouter = "/studion"
                self.currentPage = 3
            case "gearshape" :
                self.mainRouter = "/setting"
                self.currentPage = 4
            default:
                self.mainRouter = "/"
                self.currentPage = 0
            }
        }) {
            
            Image(systemName: "\(tabBarImageNames[index])")
                .foregroundColor(currentPage == index ? Color.green : Color.gray)
                .padding()
                
        }
    }
}

