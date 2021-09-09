//
//  InfoView.swift
//  personal card
//
//  Created by Akash G Krishnan on 09/09/21.
//

import SwiftUI

struct InfoView: View {
    
    let text : String
    let imageName : String
    var body: some View {
        RoundedRectangle(cornerRadius: 25).fill(Color.white).frame(height: 40).overlay(
            HStack {
                
                Image(systemName: imageName).foregroundColor(.green)
                
                Text(text)
            }
        ).padding(.all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Hello", imageName:  "phone.fill").previewLayout(.sizeThatFits)
    }
}
