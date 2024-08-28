//
//  WeatherDayView.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/30/24.
//

import SwiftUI

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    let animNamespace: Namespace.ID
    let isNight: Bool
    
    
    var body: some View {
        VStack{
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(isNight ? Color.white : Color.black)
            Image(systemName:imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .matchedGeometryEffect(id: dayOfWeek, in: animNamespace)
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(isNight ? Color.white : Color.black)
            
        }
    }
}


//#Preview {
//    WeatherDayView(dayOfWeek: "Monday", imageName: "sun.max.fill", temperature: 30)
//}
