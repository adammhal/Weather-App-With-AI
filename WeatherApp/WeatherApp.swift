//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/7/24.
//

import SwiftUI
import TipKit

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            MainWeatherView()
                .task {
                    try? Tips.configure([
                        .datastoreLocation(.applicationDefault)])
                        
                }
        }
    }
}
