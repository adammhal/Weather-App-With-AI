//
//  AlertItem.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/13/24.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    //MARK: - Coordinate Alerts
    
    static let unknownLocation = AlertItem(title: Text("Location Unknown"),
                                           message: Text("The location you provided was not found, please ensure it is in CITY,STATE,COUNTRY format. Only provide a 2 letter identifier for the state and country."),
                                           dismissButton: .default(Text("Ok")))
    
}
