//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/30/24.
//

import Foundation

struct coord: Decodable {
    let lon: Double
    let lat: Double
}


struct weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int
    let grnd_level: Int
    let temp_kf: Double?
}

struct wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct rain: Codable {
    enum CodingKeys: String, CodingKey {
        case hour = "1h"
        case twoHour = "2h"
        case threeHour = "3h"
    }
    let hour: Double?
    let twoHour: Double?
    let threeHour: Double?
}

struct clouds: Codable {
    let all: Int
}
struct sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
