//
//  InstrumentControllerView.swift
//  studion_application_swiftUI
//
//  Created by 김진홍 on 2022/03/24.
//

import SwiftUI



var instrument = ["drum", "piano_button", "guitar"]
struct InstrumentControllerView: View {
    var dcDic:[String: Any]
    
    
    @State var selectedTab = "drum"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    
    
    var body: some View {
        VStack{
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                TabView(selection: $selectedTab) {
                    
                    DrumView(dcDic: dcDic)
                        .tag("drum")
                    
                    PianoView()
                        .tag("piano_button")
                    
                    GuitarView()
                        .tag("guita")
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .ignoresSafeArea(.all, edges: .bottom)
                
                HStack(spacing: 0) {
                    ForEach(instrument, id: \.self) { image in
                        InstrumentButton(image: image, selectedTab: $selectedTab)
                        
                        if image != instrument.last {
                            Spacer(minLength: 0)
                        }
                    }
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 5)
                .background(Color.white)
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.15), radius: 5, x:5, y: 5)
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
                .padding(.horizontal)
                .padding(.bottom, edge!.bottom == 0 ? 20: 0)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
        }
    }
}

struct InstrumentButton: View {
    var image: String
    
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {selectedTab = image}) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 24, height: 24)
                .foregroundColor(selectedTab == image ? Color.gray: Color.black)
                .padding()
            
        }
    }
}
