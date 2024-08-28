//
//  String Extension.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/31/24.
//

import Foundation

extension String {
    func turnIntoIcon(isNight n: Bool) -> String {
        switch self.lowercased() {
        case "clear sky":           return n ? "moon.stars.fill" : "sun.max.fill"
        case "few clouds":          return n ? "cloud.moon.fill" : "cloud.sun.fill"
        case "scattered clouds":    return "cloud.fill"
        case "broken clouds":       return "smoke.fill"
        case "shower rain":         return n ? "cloud.moon.rain.fill" : "cloud.sun.rain.fill"
        case "rain":                return n ? "cloud.moon.rain.fill" : "cloud.rain.fill"
        case "thunderstorm":        return "cloud.bolt.rain.fill"
        case "snow":                return "snowflake"
        case "mist":                return n ? "moon.haze.fill" : "sun.haze.fill"
        case "drizzle":             return "cloud.drizzle.fill"
        case "smoke":               return "smoke.circle.fill"
        case "haze":                return n ? "moon.haze.fill" : "sun.haze.fill"
        case "dust":                return n ? "moon.dust.fill" : "sun.dust.fill"
        case "fog":                 return "cloud.fog.fill"
        case "sand":                return "cloud.fog.fill"
        case "ash":                 return n ? "moon.dust.fill" : "sun.dust.fill"
        case "squall":              return n ? "moon.dust.fill" : "sun.dust.fill"
        case "tornado":             return "tornado"
        case "clear":               return n ? "moon.stars.fill" : "sun.max.fill"
        case "clouds":              return "cloud.fill"
        default:                    return "questionmark.circle.fill"
        }
    }
}
