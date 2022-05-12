import AudioKit
import AudioKitUI
import AVFoundation
import SwiftUI

struct WaveView: View {
    
    let url: URL
    
    @State var table: Table?
    @State var isUrl = false

    var body: some View {
        
        VStack {
            
            if isUrl {
                
                TableDataView(view: TableView(table!))
                              
            } else {
                Text("URL Error")
            }
                              
        }
        .onAppear{
            do {
                
                let file = try! AVAudioFile(forReading: url)
                table = Table(file: file)
                isUrl = true
                
            } catch {
                print(error.localizedDescription)
            }
        }
                          
        
        
    }
}


struct TableDataView: UIViewRepresentable {
    typealias UIViewType = TableView
    var view: TableView

    func makeUIView(context: Context) -> TableView {
        view.backgroundColor = UIColor.green
        return view
    }

    func updateUIView(_ uiView: TableView, context: Context) {
        //
    }

}
