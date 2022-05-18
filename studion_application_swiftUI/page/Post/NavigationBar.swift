//
//  NavigationBar.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/04/01.
//

import SwiftUI

struct NavigationBar: View {
    
    @State var title = ""
    @State var text = ""
    
//    @Binding var hasScrolled: Bool
    @State var showSearch = false
    
    var body: some View {
        
        if UIDevice.isIpad {
            
            ZStack {
                Text(title)
                    .font(.largeTitle.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 20)
            }
            .frame(height: 70)
            .frame(maxHeight: .infinity, alignment: .top)
            .background(.green)
            .edgesIgnoringSafeArea(.top)
            
        } else {
            
            ZStack {
                Color.white
//                    .background(.ultraThinMaterial)
    //                    .blur(radius: 10) // bottom line (on: soft, off: hard)
    //                .opacity(hasScrolled ? 1 : 0)
                
                Text(title)
                    .font(.largeTitle.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 20)
    //                .offset(y: hasScrolled ? -4 : 0)
                
//                HStack(spacing: 20) {
//                    Button {
//                        showSearch = true
//                    } label: {
//                        Image(systemName: "magnifyingglass")
//                            .font(.body.weight(.bold))
//                            .frame(width: 36, height: 36)
//                            .foregroundColor(.secondary)
//                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
//                    }
//                    .sheet(isPresented: $showSearch) {
//                        SearchView()
//                    }
//                }.ignoresSafeArea(.all)
//                .frame(maxWidth: .infinity, alignment: .trailing)
//                .padding(.trailing, 20)
//                .padding(.top, 20)
                
            }
            .ignoresSafeArea(.all)
            .frame(height: 70)
            .frame(maxHeight: .infinity, alignment: .top)
            
        } // if
        
       
    }
}

//struct NavigationBar_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationBar(title: "NavBar")
//    }
//}
