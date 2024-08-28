//
//  WeatherCardView.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/2/24.
//

import SwiftUI

struct WeatherCardView: View {
    let imageName: String
    let weather: dayWeather
    let dayOfWeek: String
    let animNamespace: Namespace.ID
    @Binding var isShowingDetail: Bool
    @Binding var isShowingDetailFinished: Bool
    @Binding var isShowingDetailMain: Bool
    @State var cloudValue = 0
    @State var expand = false
    @State var expand2 = false
    let isNight: Bool
    
    var body: some View {
        ZStack {
            VStack{
                
                HStack {
                    DetailStatusView(infoType: "Humidity",
                                     imageName: "drop.fill",
                                     weatherInfo: Double(weather.main.humidity),
                                     expand2: $expand2,
                                     isNight: isNight)
                    .scaleEffect(expand ? 0.7 : 0.3)
                    .offset(x: expand ? -9 : 80, y: expand ? -100 : 125)
                    .animation(.bouncy, value: expand)
                    DetailStatusView(infoType: "Precipitation",
                                     imageName: "",
                                     weatherInfo: Double(weather.pop*100),
                                     expand2: $expand2,
                                     isNight: isNight)
                    .scaleEffect(expand ? 0.7 : 0.3)
                    .offset(x: expand ? 9 : -80, y: expand ? -100 : 125)
                    .animation(.bouncy, value: expand)
                }
                .opacity(!expand ? 0 : 1)
                HStack {
                    DetailStatusView(infoType: "Clouds",
                                     imageName: "drop.fill",
                                     weatherInfo: Double(cloudValue),
                                     expand2: $expand2,
                                     isNight: isNight)
                    .scaleEffect(expand ? 0.7 : 0.3)
                    .offset(x: expand ? -9 : 80, y: expand ? 100 : -130)
                    .animation(.bouncy, value: expand)
                    DetailStatusView(infoType: "Wind",
                                     imageName: "",
                                     weatherInfo: Double(weather.wind.speed),
                                     expand2: $expand2,
                                     isNight: isNight)
                    .scaleEffect(expand ? 0.7 : 0.3)
                    .offset(x: expand ? 9 : -80, y: expand ? 100 : -130)
                    .animation(.bouncy, value: expand)
                }
                .opacity(!expand ? 0 : 1)
                
                
            }
//            let _ = print(dayOfWeek)
            Image(systemName: imageName)
                .resizable()
                .matchedGeometryEffect(id: dayOfWeek, in: animNamespace)
                .aspectRatio(contentMode: .fit)
                .symbolRenderingMode(.multicolor)
                .frame(width: 300, height: 225)
            
        }
        .onTapGesture {
            withAnimation {
                isShowingDetail = false
                isShowingDetailMain = false
            } completion: {
                isShowingDetailFinished = true
            }
        }
        .task {
            await delay1()
            await delay2()
        }
        .onAppear {
            if weather.weather.first!.main == "Clouds" {
                if weather.cloud?.all != nil {
                    cloudValue = weather.cloud!.all
                } else {
                    cloudValue = 25
                }
            }
        }
        
        
    }
    
    private func delay1() async {
        try? await Task.sleep(nanoseconds: 500_000_000)
        expand = true
    }
    private func delay2() async {
        try? await Task.sleep(nanoseconds: 500_000_000)
        expand2 = true
    }
    
}

struct WeatherCardViewPreview: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        WeatherCardView(imageName: "sun.max.fill",
                        weather: MockData.day1, dayOfWeek: "THU",
                        animNamespace: namespace,
                        isShowingDetail: .constant(true), 
                        isShowingDetailFinished: .constant(false),
                        isShowingDetailMain: .constant(true),
                        isNight: false)
    }
}
