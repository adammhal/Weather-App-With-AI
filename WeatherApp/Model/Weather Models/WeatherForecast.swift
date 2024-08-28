//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/31/24.
//

import Foundation

struct dayWeather: Codable {
    let dt: Int
    let main: main
    let weather: [weather]
    let cloud: clouds?
    let wind: wind
    let visibility: Int
    let pop: Double
    let rain: rain?
    let sys: sysDay
    let dt_txt: String
}

struct city: Decodable {
    let id: Int
    let name: String
    let coord: coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

struct WeatherForecast: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [dayWeather]
    let city: city
}

struct sysDay: Codable {
    let pod: String
}
