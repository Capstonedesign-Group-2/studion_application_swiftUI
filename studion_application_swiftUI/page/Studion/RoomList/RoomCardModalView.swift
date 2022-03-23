//
//  RoomCardModalView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/23.
//

import SwiftUI

struct RoomCardModalView: View {
    @Binding var isShowing: Bool
    var roomInfo: RoomCodableStruct.roomInfo?
    @State var roomPassword: String = ""
    
    var body: some View {
        ZStack (alignment: .bottom){
            if isShowing {
                Color.black
                    .opacity(0.3)
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
                VStack {
                    Text(roomInfo!.title)
                        .font(.largeTitle)
                        .padding(.bottom, 15)
                    
                    Text(roomInfo!.content)
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
                        print("modal click")
                    }) {
                        Text("enter")
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 15)
                }
                .padding()
                
                
            }
            .frame(maxHeight: .infinity)
            
        }
        .frame(height: 400)
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}


