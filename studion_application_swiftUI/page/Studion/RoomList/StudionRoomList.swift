//
//  StudionRoomList.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/22.
//

import SwiftUI
import SocketIO

struct StudionRoomList: View {
    @Binding var pageStatus: String
    @Binding var roomNumber: Int
    @Binding var mainRouter: String
    
    @ObservedObject var roomSocket = RoomSocket()
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var isHide = false
    @State var showModal = false
    
    @State var roomInfo: RoomCodableStruct.roomInfo?
    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some View {
        
//        NavigationView {
            ZStack {
                VStack {
                    
                    
                        HStack(spacing: 12) {
                            Spacer()
                                .frame(width:20)
                            Text("Studion")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal)
                        .padding(.top, isHide ? 0:top!-10)
                        .padding(.top,1)
                    
                    
                                    
                    if roomSocket.roomsInfo?.rooms?.count != 0 {
                        
                        if roomSocket.roomsInfo != nil {
                            ScrollView(showsIndicators: false) {
                                
                                VStack(spacing: 0) {
                                    GeometryReader{ reader -> AnyView in
                                        let yAxis = reader.frame(in: .global).minY
                                        print(yAxis)
                                        
                                        if(yAxis < 0 && !isHide) {
                                            DispatchQueue.main.async {
                                                withAnimation{ isHide = true }
                                            }
                                        }
                                        
                                        if(yAxis > 0 && isHide) {
                                            DispatchQueue.main.async {
                                                withAnimation{ isHide = false }
                                            }
                                        }

                                        
                                        return AnyView(
                                            Text("").frame(width:0, height:0))
                                    }
                                    
    //                                NavigationLink(destination: RoomView(pageStatus: $pageStatus, roomNumber: 1), label: {
    //                                    Text("enter")
    //                                })
                                    
                                    
                                    ForEach(0..<(roomSocket.roomsInfo?.rooms?.count)!, id: \.self) { index in

                                        Button( action: {
                                            self.roomInfo = (roomSocket.roomsInfo?.rooms![index])!
                                            self.showModal = true
                                        }) {
                                            RoomCardView(roomInfo: roomSocket.roomsInfo?.rooms![index] as! RoomCodableStruct.roomInfo )
                                        }
                                    }
                                }
                                
                                

                                
                            }.navigationTitle("Studion")
                        }

                        

                        }else {
                            Spacer()
                            Text("방이 읎어")
                                .navigationTitle("Studion")
                            Spacer()

                        }
                    

                        
                    }
                
                RoomCardModalView(roomNumber: $roomNumber, pageStatus: $pageStatus, isShowing: $showModal, roomInfo: roomInfo)
                
                
            
            } // ZStack
//        }
        .onAppear{
            roomSocket.getRoomList()
            
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") // Forcing the rotation to portrait
            AppDelegate.orientationLock = .portrait
            
            print("AAAAAAAAAAAAAAAAAAAA")
            print(roomSocket.roomsInfo?.rooms)
        }
        
        

            
        
        

    }
}

final class RoomSocket: ObservableObject {
    
    @Published var roomsInfo: RoomCodableStruct.roomsInfo?
    
    init() {
        let socket: SocketIOClient = SocketIO.sharedInstance.getSocket()
        
        
        socket.emit("get_room_list")
        
        socket.on("update_room_list_on") {data, ack in
            let response: [String: Any] = data[0] as! Dictionary<String, Any>
            let decoder = JSONDecoder()
            do {
                let responseData = try JSONSerialization.data(withJSONObject: response, options: [.fragmentsAllowed])

                self.roomsInfo = try decoder.decode(RoomCodableStruct.roomsInfo.self, from: responseData)
                
                print("room list update")
//                print(self.roomsInfo)
            } catch {
                print("error")
            }
            
        }
        
        socket.on("get_room_list_on") {data, ack in
            let response: [String: Any] = data[0] as! Dictionary<String, Any>
//            print(response)
            let decoder = JSONDecoder()
            do {
                let responseData = try JSONSerialization.data(withJSONObject: response, options: [.fragmentsAllowed])

                self.roomsInfo = try decoder.decode(RoomCodableStruct.roomsInfo.self, from: responseData)
//                print(self.roomsInfo)
            } catch {
                print("error")
            }
        }
        
    }
    
    func getRoomList() {
        let roomListController = RoomListController()
        roomListController.getRoomList()
        
        let socket: SocketIOClient = SocketIO.sharedInstance.getSocket()
    }
}


extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
}


