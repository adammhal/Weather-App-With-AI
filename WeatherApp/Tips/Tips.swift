//
//  ShakeForNightTip.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/8/24.
//

import Foundation
import TipKit

struct ShakeForNightTip: Tip {
    var title: Text {
        Text("Shake To Change The Time")
            .foregroundStyle(.primary)
    }
    var message: Text? {
        Text("Shake your phone to toggle the time of the weather.")
    }
    
    var image: Image? {
        Image(systemName: "moon.fill")
            .symbolRenderingMode(.multicolor)
        
    }
}
