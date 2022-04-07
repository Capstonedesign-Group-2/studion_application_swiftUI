//
//  SearchView.swift
//  studion_application_swiftUI
//
//  Created by Jinho Kim on 2022/04/04.
//

import SwiftUI

struct SearchView: View {
    
    @State var text = ""
    
    var body: some View {
        NavigationView {
            List {
//                ForEach(courses.filter { $0.title.contains(text) }) { item in
//                    Text(item.title)
//                }
            }
            .searchable(text: $text, placement:
                    .navigationBarDrawer(displayMode: .always), prompt: Text("Search Anything"))
            .navigationBarTitle("Search", displayMode: .automatic)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
