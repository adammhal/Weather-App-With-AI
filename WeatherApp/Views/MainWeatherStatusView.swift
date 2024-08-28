//
//  MainWeatherStatusView.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/30/24.
//

import SwiftUI

struct MainWeatherStatusView: View {
    var imageName: String
    var temperature: Int
    var count: Int
    let animNamespace: Namespace.ID
    let dayOfWeek: String
    let isNight: Bool
    
    var body: some View {
        VStack(spacing: 8){
            Image(systemName: imageName)
                .symbolRenderingMode(imageName == "questionmark.circle.fill" ? .hierarchical : .multicolor)
                .resizable()
                .matchedGeometryEffect(id: dayOfWeek, in: animNamespace)
                .symbolEffect(.bounce, value: count)
                .aspectRatio(contentMode: .fit)
                .frame(width:180,height:180)
                .foregroundStyle(imageName == "questionmark.circle.fill" ? .blue : .primary)
            
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundStyle(isNight ? Color.white : Color.black)
        }
        .padding(.bottom, 40)
    }
}

//                              #Preview {
//                    MainWeatherStatusView(imageName: "questionmark.circle.fill", temperature: 30)
//                }
