//
//  ContentView.swift
//  hacker news
//
//  Created by Akash G Krishnan on 09/09/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager : NetworkManager = NetworkManager()
    
    var body: some View {
        NavigationView{
            List(networkManager.posts) {
                (post: Post) in
                NavigationLink(
                    destination: DetailView(url: post.url),
                    label: {
                        HStack {
                            Text("\(post.points)")
                            Text(post.title)
                        }
                    })
                
            }
            .navigationBarTitle("News")            
        }.onAppear {
            self.networkManager.fetchData()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
