import AudioKit
import AudioKitUI
import AVFoundation
import SwiftUI

struct WaveView: View {
    
    let url: URL
    
    @State var table: Table?
    @State var isUrl = false
    
    @State var width: CGFloat = 0
    @State var width1: CGFloat = 650

    var body: some View {
        
        ZStack {
            
            VStack {
                
                if isUrl {
                    
                    TableDataView(view: TableView(table!))
                        .frame(width: 650, height: 200)
                        
                    RangeSlider(width: self.$width, width1: self.$width1)
                                  
                } else {
                    Text("URL Error")
                }
                                  
            }   // VStack
            .onAppear{
                do {
                    
                    let file = try! AVAudioFile(forReading: url)
                    table = Table(file: file)
                    
                    isUrl = true
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }   // ZStack
                          
        
        
    }
}


struct TableDataView: UIViewRepresentable {
    typealias UIViewType = TableView
    var view: TableView

    func makeUIView(context: Context) -> TableView {
        view.backgroundColor = UIColor.clear
        
        return view
    }

    func updateUIView(_ uiView: TableView, context: Context) {
        //
    }

}


