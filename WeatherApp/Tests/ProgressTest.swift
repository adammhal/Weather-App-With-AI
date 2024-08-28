//
//  ProgressTest.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/3/24.
//

import SwiftUI

struct ProgressTest: View {
    @State private var progress: CGFloat = 0.2
    
    var body: some View {
        VStack{
            CircularProgressView(progress: progress)
                .frame(width: 200, height: 200)
            Slider(value: $progress, in: 0...1)
                .padding()
        }
    }
}

#Preview {
    ProgressTest()
}
