//
//  AnimatedBGView.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/12/24.
//

import SwiftUI

struct AnimatedBGView: View {
    @Binding var animateGradient: Bool
    let colors: [Color]
    
    var body: some View {
        let random1 = Double.random(in: 45...90)
        let random2 = Double.random(in: 0...45)
        
        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
            .hueRotation(.degrees(animateGradient ? random1 : random2))
            .ignoresSafeArea()
            .onAppear {
                animateGradient = true
                DispatchQueue.main.async {
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block:  { _ in
                        withAnimation(.easeInOut(duration: 2)){
                            animateGradient.toggle()
                        }
                    })
                }
                
            }
    }
}


//#Preview {
//    AnimatedBGView(animateGradient: .constant(false), colors: [.red, .blue])
//}

struct AnimatedBGViewPreview:PreviewProvider {
    @State static var ag = false
    
    static var previews: some View {
        AnimatedBGView(animateGradient: $ag, colors: [.red,.blue])
    }
}
