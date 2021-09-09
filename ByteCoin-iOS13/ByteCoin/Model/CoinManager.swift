//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdateCurrency(rate : Double)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "B519E421-3CBE-4E6B-9B7A-4728FD456F68"
    
    var delegate : CoinManagerDelegate?
    
    // https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=B519E421-3CBE-4E6B-9B7A-4728FD456F68
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency : String)  {
        //Use String concatenation to add the selected currency at the end of the baseURL along with the API key.
        let urlString = "\(baseURL)\(currency)?apikey=\(apiKey)"
        //Use optional binding to unwrap the URL that's created from the urlString
        if let url = URL(string: urlString) {
            //Create a new URLSession object with default configuration.
            let session = URLSession(configuration: .default)
            //Create a new data task for the URLSession
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error ?? "error")
                    return
                }
                if let jsonData = data {
                    let price : Double? =  self.parseJson(json: jsonData)
                    if let rate = price {
                        self.delegate?.didUpdateCurrency(rate: rate)
                        print(rate)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJson(json jsonData: Data) -> Double? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: jsonData)
            let price : Double = decodedData.rate
            return price
        } catch {
            print("error")
            return nil
        }
    }
}
