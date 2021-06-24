//
//  ContentView.swift
//  PinSpinner WatchKit Extension
//
//  Created by user198417 on 6/21/21.
//

import SwiftUI

struct MultiPicker: View  {

    typealias Label = String
    typealias Entry = String

    let data: [ (Label, [Entry])]
    @Binding var selection: [Entry]
    var padding : CGFloat = 10
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(0..<self.data.count) { column in
                    Picker(self.data[column].0, selection: self.$selection[column]) {
                        ForEach(0..<self.data[column].1.count) { row in
                            Text(verbatim: self.data[column].1[row])
                            .tag(self.data[column].1[row])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: (geometry.size.width-padding) / CGFloat(self.data.count), height: geometry.size.height)
                    .clipped()
                }
            }
        }
    }
}
    
struct ContentView: View {
    @State var data: [(String, [String])] = []
    var numberOfDigits : Int
    @State var selection: [String] = [0, 0, 0,0].map { "\($0)" }
    @State var isSet : Bool = false
    var body: some View {
        VStack(alignment: .center) {
            Text("Choose Pin")
            if isSet{
                MultiPicker(data: data, selection: $selection, padding: 10).frame(height: 50).padding(20).font(.system(size: 12))
            }
        }
        .onAppear(){
            for _ in 0..<numberOfDigits{
                data.append(("",Array(0...9).map { "\($0)" }))
                selection.append("0")
            }
            isSet = true
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(numberOfDigits: 4)
    }
}
