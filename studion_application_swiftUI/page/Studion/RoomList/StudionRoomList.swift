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
    
    @State var selectRoomCheck = false
    @State var selectRoomNumber = -1
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State var degressDic: [Int: Double] = [:]
    
    var body: some View {
        
//        NavigationView {
            ZStack {
                VStack {
                    
                                    
                    if roomSocket.roomsInfo?.rooms?.count != 0 {
                        
                        if roomSocket.roomsInfo != nil {
                            
                            Spacer()
                                .frame(height: 30)
                            
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
                                    
//                                    NavigationLink(destination: RoomView(selectRoomCheck: $selectRoomCheck, roomNumber: 1), label: {
//                                        Text("enter")
//                                    })
                                    
                                    
                                    ForEach(0..<(roomSocket.roomsInfo?.rooms?.count)!, id: \.self) { index in
                                        
                                        

                                        Button( action: {
                                            self.roomInfo = (roomSocket.roomsInfo?.rooms![index])!
                                            
                                            withAnimation{
                                                roomSocket.degressDic[index]! += 360
                                            }
                                            print(showModal)
                                            
                                            self.showModal = true
                                            
                                            
                                            
                                        }) {
                                            RoomCardView(roomInfo: (roomSocket.roomsInfo?.rooms![index])! )
                                                .rotation3DEffect(.degrees(roomSocket.degressDic[index]!), axis: (x: 0, y: 1, z: 0))
                                        }
                                        
                                    }
                                }
                                
                                

                                
                            }   // ScrollView
                            
//                            navigationTitle("Studion")
//                            .padding(.top, 30)
//                            .navigationTitle("Studion")
//                            .navigationBarTitleDisplayMode(.inline)
                            

                        }


                        } else {
                            Spacer()
                            Text("今は静かですね。")
                                .foregroundColor(Color("mainDark"))
                                .font(.largeTitle).fontWeight(.bold)
                            Spacer()

                        }
                    

                        
                    }   // VStack
                
                .safeAreaInset(edge: .top, alignment: .center, spacing: 0) {
                    Color.clear
                        .frame(height: 70)
                                 .background(Material.bar)
                }

                NavigationBar(title: "スタジオん")
                
                RoomCardModalView(roomNumber: $roomNumber, pageStatus: $pageStatus, isShowing: $showModal, roomInfo: roomInfo, selectRoomCheck: $selectRoomCheck, selectRoomNumber: $selectRoomNumber)
                    
                
                
                
                NavigationLink(destination: RoomView(selectRoomCheck: $selectRoomCheck, roomNumber: selectRoomNumber), isActive: $selectRoomCheck , label: {})
                
                
            
            } // ZStack
            
//            .navigationTitle("Studion")
//            .navigationBarTitleDisplayMode(.inline)
            
            
//        } // NavigationView
//        .navigationViewStyle(.stack)
        
        .onAppear{
            roomSocket.getRoomList()
            
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") // Forcing the rotation to portrait
            AppDelegate.orientationLock = .portrait
            
//            print(roomSocket.roomsInfo?.rooms)
            
            
        }
        
        

            
        
        

    }
}

final class RoomSocket: ObservableObject {
    
    @Published var roomsInfo: RoomCodableStruct.roomsInfo?
    @Published var degressDic: [Int: Double] = [:]
    
    init() {
        let socket: SocketIOClient = SocketIO.sharedInstance.getSocket()
        
        
        socket.emit("get_room_list")
                
                socket.on("update_room_list_on") {data, ack in
                    self.degressDic = [:]
//                    print(data)
                    let response: [String: Any] = data[0] as! Dictionary<String, Any>
                    let decoder = JSONDecoder()
                    do {
                        let responseData = try JSONSerialization.data(withJSONObject: response, options: [.fragmentsAllowed])

                        
                        self.roomsInfo = try decoder.decode(RoomCodableStruct.roomsInfo.self, from: responseData)
                        
                        var count = 0
                        
                        self.roomsInfo?.rooms?.forEach {_ in
                            self.degressDic[count] = 0.0
                            count += 1
                        }
                        
                        print("room list update")

                    } catch {
                        print("room list error")
                        print(error.localizedDescription)
                    }
                    
                    
                }
                
                socket.on("get_room_list_on") {data, ack in
                    self.degressDic = [:]
                    let response: [String: Any] = data[0] as! Dictionary<String, Any>
//                    print(response)
                    let decoder = JSONDecoder()
                    do {
                        let responseData = try JSONSerialization.data(withJSONObject: response, options: [.fragmentsAllowed])

                        self.roomsInfo = try decoder.decode(RoomCodableStruct.roomsInfo.self, from: responseData)
                        
                        var count = 0
                        
                        self.roomsInfo?.rooms?.forEach {_ in
                            self.degressDic[count] = 0.0
                            count += 1
                        }
                        print("get room list on")
                    } catch {
                        print("room list error2")
                        print(error.localizedDescription)
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


