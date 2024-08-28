//
//  MainAIView.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/6/24.
//

import SSSwiftUIGIFView
import SwiftUI


struct MainAIViewTest: View {
    
    let isLoaded = true
    let clothingDesc = "nice and toasty"
    let headChoice = "scarf"
    let bodyChoice = "longsleeve"
    let legChoice = "sweatpants"
    @State var headScale: CGFloat = 1
    @State var headPadding: CGFloat = 1
    @State var bodyScale: CGFloat = 1
    @State var bodyPadding: CGFloat = 1
    @State var legScale: CGFloat = 1
    @State var legPadding: CGFloat = 1
    
    var body: some View {
        ZStack {
            VStack {
                ZStack (alignment: .topLeading){
                    if(isLoaded){
                        ZStack {
                            GlassyView(width: 350, height: 200)
                            Text(clothingDesc)
                                .foregroundStyle(Color.black.opacity(0.8))
                            //                                .font(.system(size: 16.5, weight: .semibold, design: .rounded))
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
                                .frame(width: 325, height: 200)
                                .scaledToFit()
                        }
                    }
                    
                }
                if(isLoaded) {
                    ZStack {
                        GlassyView(width: 200, height: 400)
                        VStack (alignment: .leading){
                            Image(headChoice)
                                .outfitImageStyle()
                                .scaleEffect(headScale)
                                .padding(.bottom, headPadding)
                            Image(bodyChoice)
                                .outfitImageStyle()
                                .scaleEffect(bodyScale)
                                .padding([.top, .bottom], bodyPadding)
                            Image(legChoice)
                                .outfitImageStyle()
                                .scaleEffect(CGFloat(legScale))
                                .padding(.top, legPadding)
                        }.onAppear {
                            switch headChoice {
                                case "cap":
                                headScale = 0.6
                                    headPadding = 0
                                case "sunglasses":
                                    headScale = 0.6
                                    headPadding = 0
                                default:
                                headScale = 0.6
                                    headPadding = 0
                            }
                            switch bodyChoice {
                                case "tshirt":
                                    bodyScale = 1
                                    bodyPadding = 0
                                case "longsleeve":
                                bodyScale = 1.1
                                    bodyPadding = 0
                            case "coat":
                                bodyScale = 1.3
                                bodyPadding = 1
                                default:
                                    bodyScale = 1
                                    bodyPadding = 0
                            }
                            switch legChoice {
                                case "sweatpants":
                                    legScale = 1.5
                                    legPadding = 30
                                case "cargopants":
                                    legScale = 0.9
                                    legPadding = 0
                                case "shorts":
                                    legScale = 1
                                    legPadding = -10
                            case "winterpants":
                                legScale = 1.4
                                legPadding = 30
                            case "jeans":
                                legScale = 1.3
                                legPadding = 25
                                default:
                                    legScale = 1
                                    legPadding = 0
                            }
                            
                        }
                        VStack {
                            if(!isLoaded){
                                SwiftUIGIFPlayerView(gifName: "loadingGif", isShowProgressView: true)
                                    .padding(.top, 175)
                                    .scaleEffect(0.6)
                            }
                        }
                    }
                    .animation(.easeInOut, value: isLoaded)
                    
                }
            }
        }
    }
}
struct MainAITestPreview: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [.blue,.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
            MainAIViewTest()
        }
    }
}


