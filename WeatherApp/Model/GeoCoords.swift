//
//  GeoCoords.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/13/24.
//

import Foundation

struct GeoCoords: Decodable {
    let name: String
    let local_names: [String: String]
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}

