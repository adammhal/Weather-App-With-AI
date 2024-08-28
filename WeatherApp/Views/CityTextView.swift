//
//  CityTextView.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/30/24.
//

import SwiftUI

struct CityTextView: View {
    let cityNamespace: Namespace.ID
    var cityName: String
    let isNight: Bool
    
    var body: some View {
        Text(cityName)
            .matchedGeometryEffect(id: "city", in: cityNamespace)
            .font(.system(size: 32,weight:.medium))
            .foregroundStyle(isNight ? Color.white : Color.black)
            .padding()
    }
}

//#Preview {
//    CityTextView(cityName: "Plano", isNight: false)
//}
