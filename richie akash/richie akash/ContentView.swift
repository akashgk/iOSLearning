//
//  ContentView.swift
//  richie akash
//
//  Created by Akash G Krishnan on 08/09/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemTeal).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Text("I Am Rich")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                    .padding()
            }
            
            
        }

    

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
