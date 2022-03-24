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
    @State var roomPassword: String = ""
    
    @State private var isDragging = false
    @State private var curHeight: CGFloat = 400
    let minHeight: CGFloat = 400
    let maxHeight: CGFloat = 700
    
    let startOpacity: Double = 0.4
    let endOpacity: Double = 0.8
    
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
                VStack {
                    Text(roomInfo!.title)
                        .font(.largeTitle)
                        .padding(.bottom, 15)
                    
                    Text(roomInfo!.content)
                        .font(.body)
                        .padding(.bottom, 15)
                    
                    Text(String(roomInfo!.users.count))
                        .font(.body)
                        .padding(.bottom, 15)
                    
                    if roomInfo!.locked == 1 {
                        SecureField("Password", text: $roomPassword)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                    }
                    
                    Button( action : {
                        
                        self.roomNumber = roomInfo!.id
                        self.isShowing = false
                        self.pageStatus = "/room"
                        print("modal click")
                    }) {
                        Text("enter")
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 100)
                }
                .padding(.horizontal, 30)
                
                
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
            
        }
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: curHeight / 2)
            }
            .foregroundColor(.white)
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


