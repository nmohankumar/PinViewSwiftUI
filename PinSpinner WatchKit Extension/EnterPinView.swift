//
//  EnterPinView.swift
//  PinSpinner WatchKit Extension
//
//  Created by user198417 on 6/24/21.
//

import SwiftUI

let buttonColor : UIColor = UIColor(red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1)

struct rounded: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(RoundedRectangle(cornerRadius:5).fill(Color.init(buttonColor)))
    }
}

struct PinButton: View {
    var value: String
    @Binding var keyFrame : CGRect
    @Binding var keyStroke : String
    var action : (String) -> ()
    var body: some View {
        GeometryReader { geometry  in
            let frame = geometry.frame(in: CoordinateSpace.global)
            ZStack{
                Button(value){}
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .modifier(rounded())
                    .buttonStyle(PlainButtonStyle())
                    Text(value)
            }.onTapGesture {
                if value != "Cancel"{
                    keyFrame = frame
                    keyStroke = value
                    action(value)
                }
            }
        }
        
    }
}

struct EnterPinView: View {
    @State var frame : CGRect = CGRect.zero
    @State var keyStroke : String = ""
    @State var passCode : String = "Enter current passcode"
    func keyPressed(key: String){
        if passCode == "Enter current passcode"{
            passCode = ""
        }
        if key == "X"{
            passCode.removeLast()
        }
        else{
            passCode += key
        }
        if passCode == ""{
            passCode = "Enter current passcode"
        }
    }
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                VStack(spacing:2){
                    Text(passCode).font(.caption2)
                    HStack(spacing:2){
                        PinButton(value: "1", keyFrame: $frame, keyStroke: $keyStroke, action: keyPressed(key:))
                        PinButton(value: "2", keyFrame: $frame, keyStroke: $keyStroke, action: keyPressed(key:))
                        PinButton(value: "3", keyFrame: $frame, keyStroke: $keyStroke, action: keyPressed(key:))
                    }
                    HStack(spacing:1){
                        PinButton(value: "4", keyFrame: $frame, keyStroke: $keyStroke, action: keyPressed(key:))
                        PinButton(value: "5", keyFrame: $frame, keyStroke: $keyStroke, action: keyPressed(key:))
                        PinButton(value: "6", keyFrame: $frame, keyStroke: $keyStroke, action: keyPressed(key:))
                    }
                    
                    HStack(spacing:1){
                        PinButton(value: "7", keyFrame: $frame, keyStroke: $keyStroke, action: keyPressed(key:))
                        PinButton(value: "8", keyFrame: $frame, keyStroke: $keyStroke, action: keyPressed(key:))
                        PinButton(value: "9", keyFrame: $frame, keyStroke: $keyStroke, action: keyPressed(key:))
                    }
                    
                    HStack(spacing:1){
                        PinButton(value: "X", keyFrame: $frame, keyStroke: $keyStroke, action: keyPressed(key:)).frame(width:geo.size.width/3)
                        PinButton(value: "0", keyFrame: $frame, keyStroke: $keyStroke, action: keyPressed(key:)).frame(width:geo.size.width/3)
                        Spacer()
                    }
                    HStack(spacing:1){
                        PinButton(value: "Cancel", keyFrame: $frame, keyStroke: $keyStroke, action: keyPressed(key:))
                    }.frame(height:20)
                }
                .frame(height:geo.size.height)
            }
            if self.frame != CGRect.zero {
                Text(keyStroke).frame(width: 40, height: 60).background(Color.gray).cornerRadius(5).offset(x: frame.origin.x+frame.size.width/3, y: frame.origin.y-45)
                    .font(.title)
                    .animation(.default)
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.25, execute: {
                            self.frame = CGRect.zero
                        })
                    }
            }
        }
    }
}

struct EnterPinView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPinView()
    }
}
