//
//  SwiftUIView.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/5/24.
//

import SwiftUI

struct LoadingView: View {
    @Binding var isNight: Bool
    var body: some View {
        ZStack{
            BackgroundView(isNight: $isNight)
            
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(3)
                .tint(isNight ? Color.lightBlue : Color.darkBlue)
        }
    }
}

#Preview {
    LoadingView(isNight: .constant(false))
}
