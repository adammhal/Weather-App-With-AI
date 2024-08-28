//
//  DetailStatusView.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/3/24.
//

import SwiftUI

struct DetailStatusView: View {
    let infoType: String
    let imageName: String
    let weatherInfo: Double
    @Binding var expand2: Bool
    let isNight: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.tertiary)
                .frame(width: 175, height: 250)
                .clipShape(.rect(cornerRadius: 20))
//            Image(systemName: imageName)
//                .resizable()
//                .renderingMode(.original)
//                .aspectRatio(contentMode: .fit)
//                .foregroundStyle(Color.waterDrop)
//                .frame(width:200, height: 300)
                
            
            VStack{
                Text(infoType)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(isNight ? Color.white : Color.black)
                HStack{
                    ZStack{
//                        let _ = print(expand2 ? CGFloat(weatherInfo/100) : 0)
                        CircularProgressView(progress: expand2 ? CGFloat(weatherInfo/100) : 0, isNight: isNight, max: infoType == "Wind" ? 0.15 : 1)
                            .frame(width:60,height:60)
                            .padding(.trailing, 20)
                            .animation(.bouncy, value: expand2)
                        Text("\(weatherInfo, specifier: "%.0f")%")
                            .offset(x: -10)
                            .bold()
                            .foregroundStyle(isNight ? Color.white : Color.black)
                    }
                    .offset(x: 10)
                    
//                    Image(systemName: imageName)
//                        .resizable()
//                        .renderingMode(.original)
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 50, height: 50)
                }
                .padding()
                
                
            }
        }
    }
}

#Preview {
    DetailStatusView(infoType: "Humidity", imageName: "drop.fill", weatherInfo: Double(MockData.day1.main.humidity),
                     expand2: .constant(true), isNight: true)
}
