//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/31/24.
//

import Foundation
struct CurrentWeather: Decodable {
    let coord: coord
    let weather: [weather]
    let base: String
    let main: main
    let visibility: Int
    let wind: wind
    let rain: rain?
    let clouds: clouds
    let dt: Int
    let sys: sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}  
