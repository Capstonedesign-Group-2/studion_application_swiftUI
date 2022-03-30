//
//  LeftBarView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import SwiftUI

struct LeftBarView: View {
    
    
    var body: some View {
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
                    
                }   // VStack
                
                Spacer(minLength: 0)
                
                Button(action: {}) {
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color("twitter")) // Image
                } // Button
                
                
                
                
            }   // HStack
            
            Spacer(minLength: 0)
            
        } // VStack
        
        .padding(.horizontal, 20)
        .padding(.vertical)
        .frame(width: UIScreen.main.bounds.width - 90)
        .background(Color.white)
        
            
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

