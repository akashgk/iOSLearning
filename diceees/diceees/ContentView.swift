//
//  ContentView.swift
//  diceees
//
//  Created by Akash G Krishnan on 09/09/21.
//

import SwiftUI

struct ContentView: View {
    @State var leftDiceNumber : Int = 1
    @State var rightDiceNumber : Int = 1
    var body: some View {
        ZStack{
            Image("background").resizable().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Image("diceeLogo")
                Spacer()
                HStack {
                    Dice(number: leftDiceNumber)
                    Dice(number: rightDiceNumber)
                }.padding(.all)
                Spacer()
                Button(action: {
                    self.leftDiceNumber = Int.random(in: 1...6)
                    self.rightDiceNumber = Int.random(in: 1...6)
                }){
                    Text("ROll").font(.system(size: 50)).fontWeight(.heavy).foregroundColor(.white).padding()
                }.background(Color.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Dice: View {
    var number : Int

    var body: some View {
        Image("dice\(number)").resizable().aspectRatio(1, contentMode: .fit).padding()
    }
}
