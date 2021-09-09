//
//  ContentView.swift
//  personal card
//
//  Created by Akash G Krishnan on 09/09/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color(red: 0.09, green: 0.63, blue: 0.52, opacity: 1.0).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                
                Image("akash").resizable().aspectRatio(contentMode: .fit).frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).overlay(Circle().stroke(Color.white, lineWidth: 4))
                
                Text("akash")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .bold()
                    .foregroundColor(.white)
                
                Text("Mobile App Guy").font(.system(size: 25))
                    .foregroundColor(.white)
                
                Divider()
                
                InfoView(
                text: "+ 81 302338078", imageName: "phone.fill")
                
                InfoView(
                text: "akash.krishnan@fullthrotttlelabs.com", imageName: "envelope.fill")
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


