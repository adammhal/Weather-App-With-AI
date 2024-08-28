//
//  Image Extensions.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/10/24.
//

import SwiftUI

extension Image {
    func outfitImageStyle() -> some View {
        self
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(.white)
            .aspectRatio(contentMode: .fit)
            .frame(width: 100)
    }
}
