//
//  weatherDay.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/30/24.
//

import Foundation

struct WeatherDay {
    static func == (lhs: WeatherDay, rhs: WeatherDay) -> Bool {
        return lhs.day == rhs.day
    }
    
    let id = UUID()
    let day: String
    let morningWeather: dayWeather
    let nightWeather: dayWeather
}

struct GPTDay: Decodable {
    let clothingDesc: String
    let headChoice: String
    let bodyChoice: String
    let legChoice: String
}

struct CurrentDay: Encodable {
    let id = UUID()
    let day: String
    let morningWeather: dayWeather?
    let nightWeather: dayWeather?
}

struct MockData {
    static let day1 = dayWeather(dt: -1, main: main(temp: 20.3, feels_like: 3.2, temp_min: 3.0, temp_max: 4.0, pressure: 3, humidity: 5, sea_level: 9, grnd_level: 1, temp_kf: nil), weather: [weather(id: 1, main: "rain", description: "rain", icon: "10d")], cloud: nil, wind: wind(speed: 10.0, deg: 10, gust: nil), visibility: 20, pop: 0.4, rain: nil, sys: sysDay(pod: "test"), dt_txt: "2021-01-15 12-00-00")
    
    static let day2 = dayWeather(dt: -1, main: main(temp: 20.3, feels_like: 3.2, temp_min: 3.0, temp_max: 4.0, pressure: 3, humidity: 5, sea_level: 9, grnd_level: 1, temp_kf: nil), weather: [weather(id: 1, main: "rain", description: "rain", icon: "10d")], cloud: nil, wind: wind(speed: 10.0, deg: 10, gust: nil), visibility: 20, pop: 23.3, rain: nil, sys: sysDay(pod: "test"), dt_txt: "2021-01-15 12-00-00")
    
    static let day3 = dayWeather(dt: -1, main: main(temp: 20.3, feels_like: 3.2, temp_min: 3.0, temp_max: 4.0, pressure: 3, humidity: 5, sea_level: 9, grnd_level: 1, temp_kf: nil), weather: [weather(id: 1, main: "rain", description: "rain", icon: "10d")], cloud: nil, wind: wind(speed: 10.0, deg: 10, gust: nil), visibility: 20, pop: 23.3, rain: nil, sys: sysDay(pod: "test"), dt_txt: "2021-01-15 12-00-00")
    
    static let day4 = dayWeather(dt: -1, main: main(temp: 20.3, feels_like: 3.2, temp_min: 3.0, temp_max: 4.0, pressure: 3, humidity: 5, sea_level: 9, grnd_level: 1, temp_kf: nil), weather: [weather(id: 1, main: "rain", description: "rain", icon: "10d")], cloud: nil, wind: wind(speed: 10.0, deg: 10, gust: nil), visibility: 20, pop: 23.3, rain: nil, sys: sysDay(pod: "test"), dt_txt: "2021-01-15 12-00-00")
    
    static let invalidDay = dayWeather(dt: -1, main: main(temp: 20.3, feels_like: 3.2, temp_min: 3.0, temp_max: 4.0, pressure: 3, humidity: 5, sea_level: 9, grnd_level: 1, temp_kf: nil), weather: [weather(id: 1, main: "rain", description: "rain", icon: "10d")], cloud: nil, wind: wind(speed: 10.0, deg: 10, gust: nil), visibility: 20, pop: 23.3, rain: nil, sys: sysDay(pod: "test"), dt_txt: "2021-01-15 12-00-00")
    
    static let MockGPTDay = GPTDay(clothingDesc: "Nice and toasty", headChoice: "hat", bodyChoice: "coat", legChoice: "sweatpants")

    
    static let sampleDays: [WeatherDay] = []
    
}



