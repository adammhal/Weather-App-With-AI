//
//  CircularProgressView.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/3/24.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: CGFloat
    var isNight: Bool = false
    var max: Double = 1.0
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.1)
                .foregroundStyle(.blue)
            Circle()
                .trim(from: 0.0, to: min(progress,max))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundStyle(!isNight ? Color.blue : Color.darkBlue)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeOut.speed(0.8), value: progress)
            
        }
    }
}

#Preview {
    CircularProgressView(progress: 0.9)
}
