//
//  PostCard.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/04/01.
//

import SwiftUI
import UIKit

struct PostCard: View {
    
    @Namespace var namespace
    @State var show: Bool = false
    
    @State var title = ""
    @State var content = ""
    @State var image = ""
    
    var body: some View {
        ZStack{
            
            if !show {
                VStack {
                    Text(title)
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    Image(image)
                        .matchedGeometryEffect(id: "image", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .shadow(color: .gray, radius: 5)
                        .padding()
                }
            } else {
                VStack {
                    Text(title)
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    Image(image)
                        .matchedGeometryEffect(id: "image", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .shadow(color: .gray, radius: 5)
                    
                    Text(content)
                        .matchedGeometryEffect(id: "content", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()

                }
            }
        }
        
        .onTapGesture {
            withAnimation {
                show.toggle()
            }
        }.transition(.slide)
    }
}

struct PostCard_Previews: PreviewProvider {
    static var previews: some View {
        PostCard(title: "title", content: "content", image: "Studion-original")
    }
}

