//
//  BackgroundView.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/30/24.
//

import SwiftUI

struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
//        ContainerRelativeShape()
//            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
//            .ignoresSafeArea()
    }
}


#Preview {
    BackgroundView(isNight: .constant(true))
}
