//
//  WeatherButton.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/7/24.
//

import SwiftUI

struct WeatherButton: View{
    var title: String
    var textColor: Color
    var backgroundColor: Color = .white
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .background(backgroundColor.animation(.easeInOut))
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(textColor)
            .cornerRadius(10)
    }
}

struct WeatherButton_Previews: PreviewProvider {
    static var previews: some View {
        WeatherButton(title: "Test",
                      textColor: .white,
                      backgroundColor: .mint)
    }
}
