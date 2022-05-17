//
//  MainView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/22.
//

import SwiftUI

extension UIDevice { // Check iPad or iPhone
  static var idiom: UIUserInterfaceIdiom {
    UIDevice.current.userInterfaceIdiom
  }
}
extension UIDevice {
static var isIpad: Bool {
    idiom == .pad
  }
  
  static var isiPhone: Bool {
    idiom == .phone
  }
}


struct HomeView: View {
    var body: some View {
        VStack {
            MainView()
        }
    }
}

var tabs = ["house", "message", "plus", "rectangle.righthalf.inset.filled.arrow.right", "gearshape"]

struct MainView: View {
    @State var pageStatus = "/"
    @State var roomNumber = 1
    @State var mainRouter = "/"
    
    @State var selectedTab = "house"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    @State var currentPage: Int = 0
    
    var body: some View {
        
        if UIDevice.isIpad {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                
                TabView(selection: $selectedTab) {
                    PostView()
                        .tag("house")
                        .transition(.move(edge: .top))
                        .animation(.easeIn)

                    ChatRoomList()
                        .tag("message")
                  
                    CreateView()
                        .tag("plus")
                    
                    StudionRoomList(pageStatus: $pageStatus, roomNumber: $roomNumber, mainRouter: $mainRouter)
                        .tag("rectangle.righthalf.inset.filled.arrow.right")
                        .transition(.move(edge: .top))
                        .animation(.easeIn)
                    
                    SettingView(pageStatus: $pageStatus)
                        .tag("gearshape")
                }
                
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                    .ignoresSafeArea(.all, edges: .bottom)
                
                HStack(spacing: 0) {
                    
                    ForEach(tabs, id: \.self) { image in
                        TabButton(image: image, selectedTab: $selectedTab)
                        
                        if image != tabs.last {
                            Spacer(minLength: 0)
                        }
                    }
                }// hS
                .padding(.horizontal, 230)
                .padding(.vertical, 5)
                .background(Color.white)
                
            }// zS
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
            
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationViewStyle(.stack)
        
        } else { // iPhone UI

            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {

                TabView(selection: $selectedTab) {
                    PostView()
                        .tag("house")
                        .transition(.move(edge: .top))
                        .animation(.easeIn)

                    ChatRoomList()
                        .tag("message")
                  
                    CreateView()
                        .tag("plus")
                    
                    StudionRoomList(pageStatus: $pageStatus, roomNumber: $roomNumber, mainRouter: $mainRouter)
                        .tag("rectangle.righthalf.inset.filled.arrow.right")
                        .transition(.move(edge: .top))
                        .animation(.easeIn)
                    
                    SettingView(pageStatus: $pageStatus)
                        .tag("gearshape")
                }
                
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // swipe
//                .ignoresSafeArea(.all, edges: .bottom)

                HStack(spacing: 0) {
                    
                    ForEach(tabs, id: \.self) { image in
                        TabButton(image: image, selectedTab: $selectedTab)
                        
                        if image != tabs.last {
                            Spacer(minLength: 0)
                        }
                    }
                }// hS
                
                .padding(.horizontal, 25)
                .padding(.vertical, 5)
                .background(Color.white)
                
            } //zS
            
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))

            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationViewStyle(.stack)

        } // else

    }
}

struct TabButton: View {
    
    var image: String
    
    @Binding var selectedTab: String
    
    var body: some View {
        
        Button(action: {selectedTab = image}) {
            
            Image(systemName: "\(image)")
                .foregroundColor(selectedTab == image ? Color.green : Color.black)
                .padding()
        }
    }
}



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


//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(pageStatus: $pageStatus, roomNumber: <#Binding<Int>#>)
//    }
//}
