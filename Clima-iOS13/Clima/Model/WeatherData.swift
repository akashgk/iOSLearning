//
//  WeatherData.swift
//  Clima
//
//  Created by Akash G Krishnan on 07/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Decodable {
    let name : String
    let main :  MainData
    let weather : [Weather]
}

struct MainData : Decodable {
    let temp : Double
}

struct Weather : Decodable {
    let id : Int
}
