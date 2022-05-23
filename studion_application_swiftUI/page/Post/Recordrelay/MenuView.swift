//
//  MenuView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/05/18.
//

import SwiftUI

struct MenuView: View {
    
    var audioURLString: String
    
    @State var isActive: Bool = false
    
    var composers:[Any]?
    
    var body: some View {
        
        VStack {
            Menu {
                Button(action: {
                    self.isActive = true
                }, label: {
                        Text("Go to Recoding Relay")
                        .font(.body).fontWeight(.semibold)
                    })
                } label: {
                        Label("", systemImage: "ellipsis")
                }// menu
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(Color.black)
            }// vS
            
        NavigationLink(destination: RelayView(audioURLString: audioURLString, composers: composers), isActive: $isActive) {
            EmptyView()
        }// navLink
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}
