//
//  LeftBarView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import SwiftUI

struct LeftBarView: View {
    
    var volumeDic: [String: Any]
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        
        HStack (spacing: 0) {
            
            VStack(alignment: .leading) {
                Image("piano")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Kavsoft")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("@_Kavsoft")
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 20) {
                            FollowView(count: 8, title: "Following")
                                .onTapGesture {
                                    
                                }   // FollowView
                            
                            FollowView(count: 8, title: "Following")
                                .onTapGesture {
                                    
                                }   // FollowView
                            
                            
                        }   // HStack
                        .padding(.top, 10)
                        
                        Divider()
                            .padding(.top)
                        
                    }   // VStack
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color("twitter")) // Image
                    } // Button
                    
                }   // HStack
                
                VStack(alignment: .leading) {
                    
                } // VStack
                
                Spacer(minLength: 0)
                
            } // VStack
            
            .padding(.horizontal, 20)
            .padding(.top, edges!.top == 0 ? 15 : edges?.top)
            .padding(.top, edges!.bottom == 0 ? 15 : edges?.bottom)
            .frame(width: UIScreen.main.bounds.width * 4/5)
            .background(Color.white)
            .ignoresSafeArea(.all, edges: .vertical)
            
            Spacer(minLength: 0)
            
            
        } // HStack
        
        
            
    }
}



struct FollowView: View {
    var count: Int
    var title: String
    
    
    var body: some View {
        HStack {
            Text("\(count)")
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text(title)
                .foregroundColor(.gray)
        }
    }
}


