//
//  NetworkManager.swift
//  hacker news
//
//  Created by Akash G Krishnan on 09/09/21.
//

import Foundation

class NetworkManager : ObservableObject {

    @Published var posts : [Post] = [Post]()
    
    func fetchData() {
        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data: Data?,response: URLResponse?, error : Error? ) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                            
                        } catch {
                            print("Error on decoding")
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
