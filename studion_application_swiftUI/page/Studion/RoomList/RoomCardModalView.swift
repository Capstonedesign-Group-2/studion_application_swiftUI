//
//  RoomCardModalView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/23.
//

import SwiftUI

struct RoomCardModalView: View {
    @Binding var roomNumber: Int
    @Binding var pageStatus: String
    
    @Binding var isShowing: Bool
    var roomInfo: RoomCodableStruct.roomInfo?
    @Binding var selectRoomCheck: Bool
    @Binding var selectRoomNumber: Int
    
    @State var roomPassword: String = ""
    
    @State private var isDragging = false
    @State private var curHeight: CGFloat = 400
    let minHeight: CGFloat = 400
    let maxHeight: CGFloat = 700
    
    let startOpacity: Double = 0.4
    let endOpacity: Double = 0.8
    
    let width:CGFloat = 300
    var height: CGFloat = 20
    var color3 = Color(red: 252/255, green: 246/255, blue: 245/255)
    var color4 = Color(red: 44/255, green:95/255, blue: 45/255)
    
    
    var dragPercentage: Double {
        let res = Double((curHeight - minHeight) / (maxHeight - minHeight))
        return max(0, min(1, res))
    }
    
    var body: some View {
            ZStack (alignment: .bottom){
                if isShowing {
                    Color.black
                        .opacity(startOpacity + (endOpacity - startOpacity) * dragPercentage)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShowing = false
                        }
                    
                    roomCardModalTextView
                        .transition(.move(edge: .bottom))
                    
                        
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .animation(.easeInOut)
        
    }
    
    var roomCardModalTextView: some View {
        
        
        VStack {
            
            ZStack {
                Capsule()
                    .frame(width: 40, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            
            
            ZStack {
                NavigationView {
                    ZStack {
                        VStack {
                            
                            VStack {
                                Text(roomInfo!.title)
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                                    .padding(.bottom, 15)
                                    .foregroundColor(Color(red: 44/255, green:95/255, blue: 45/255))
                                
                                Text(roomInfo!.content)
                                    .font(.body)
                                    .padding(.bottom, 15)
                                    .foregroundColor(Color(red: 44/255, green:95/255, blue: 45/255))
                                
        //                        Text(String(roomInfo!.users.count))
        //                            .font(.body)
        //                            .padding(.bottom, 15)
        //                            .foregroundColor(Color(red: 44/255, green:95/255, blue: 45/255))
                                
                                if roomInfo!.locked == 1 {
                                    SecureField("Password", text: $roomPassword)
                                        .padding()
                                        .background(lightGreyColor)
                                        .cornerRadius(5.0)
                                        .padding(.bottom, 20)
                                }
                                
                                ZStack(alignment: .leading) {
                                    let multiplier = width / 4
                                    var percent: CGFloat = CGFloat(roomInfo!.users.count)
                                    
                                    RoundedRectangle(cornerRadius: height, style: .continuous)
                                        .frame(width: width, height: height)
                                        .foregroundColor(Color.black.opacity(0.1))
                                    
                                    RoundedRectangle(cornerRadius: height, style: .continuous)
                                        .frame(width: percent * multiplier, height: height)
                                        .background(LinearGradient(gradient: Gradient(colors: [color3, color4]), startPoint: .leading, endPoint: .trailing)
                                                        .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
                                        )
                                        .foregroundColor(.clear)
                                }

                                
                                
                                                        
//                                Button( action: {
//        //                            self.roomNumber = roomInfo!.id
//        //                            self.pageStatus = "/room"
//                                    self.selectRoomNumber = roomInfo!.id
//                                    self.selectRoomCheck = true
//                                } ) {
//                                    Text("enter")
//                                }
//                                .padding(.horizontal, 30)
//                                .padding(.bottom, 100)
                                
                                Button( action: {
                                    self.selectRoomNumber = roomInfo!.id
                                    self.selectRoomCheck = true
                                }) {
                                    Text("Enter")
                                        .bold()
                                        .frame(width: 200, height: 50)
                                        .foregroundColor(Color(red: 44/255, green:95/255, blue: 45/255))
                                        .background(LinearGradient(gradient: Gradient(colors: [color3, color4]), startPoint: .leading, endPoint: .trailing))
                                        .clipShape(Capsule())
                                    
                                }
                                
                                
                            }   // VStack
                            .padding()
                            
                            
                            
                            
                            
                        }   // VStack
                        .frame(width: UIScreen.main.bounds.width, height: curHeight)
                        .background(Color(red: 151/255, green: 188/255, blue:98/255))
                        .padding(.horizontal, 30)
                        .zIndex(1)
                        
                        
//                        Spacer()
//                            .frame(width: UIScreen.main.bounds.width, height: curHeight)
//                            .background(.white).opacity(0.3)
//                            .padding(.horizontal, 30)
                        
                    }   // ZStack
                    
                    
                    
                    
                    

                }   // NavigationView
                
                .navigationViewStyle(.stack)
                
                
                                
                
            }   // ZStack
            
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
            
            
            
            
        }   // VStack
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: curHeight / 2)
            }
            .foregroundColor(Color(red: 151/255, green: 188/255, blue:98/255))
        )
        .animation(isDragging ? nil : .easeInOut(duration: 0.45))
    }
    
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                if !isDragging {
                    isDragging = true
                }
                
                let dragAmount = val.translation.height - prevDragTranslation.height
                if curHeight > maxHeight || curHeight < minHeight {
                    curHeight -= dragAmount / 6
                } else {
                    curHeight -= dragAmount
                }
                
                prevDragTranslation = val.translation
            }
            .onEnded { val in
                prevDragTranslation = .zero
                isDragging = false
                if curHeight > maxHeight {
                    curHeight = maxHeight
                } else if curHeight < maxHeight {
                    curHeight = minHeight
                }
            }
    }
}


