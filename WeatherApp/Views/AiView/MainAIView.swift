//
//  MainAIView.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/6/24.
//

import SSSwiftUIGIFView
import SwiftUI


struct MainAIView: View {
    @ObservedObject var vm: MainWeatherViewModel
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
                    if(vm.isAILoaded){
                        ZStack {
                            GlassyView(width: 350, height: 200)
                            Text(vm.generatedGPTDay!.clothingDesc)
                                .foregroundStyle(Color.black.opacity(0.8))
                            //                                .font(.system(size: 16.5, weight: .semibold, design: .rounded))
                                .fontWeight(.semibold)
                                .fontDesign(.rounded)
                                .frame(width: 325, height: 200)
                                .scaledToFit()
                        }
                    }
                    
                }
                if(vm.isAILoaded) {
                    ZStack {
                        GlassyView(width: 200, height: 400)
                        VStack {
                            Image(vm.generatedGPTDay!.headChoice)
                                .outfitImageStyle()
                                .scaleEffect(headScale)
                                .padding(.bottom, headPadding)
                            Image(vm.generatedGPTDay!.bodyChoice)
                                .outfitImageStyle()
                                .scaleEffect(bodyScale)
                                .padding([.top,.bottom],bodyPadding)
                            Image(vm.generatedGPTDay!.legChoice)
                                .outfitImageStyle()
                                .scaleEffect(legScale)
                                .padding(.top,legPadding)
                        }
                        
                    }.onAppear {
                        if vm.isAILoaded {
                            switch vm.generatedGPTDay?.headChoice {
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
                            switch vm.generatedGPTDay?.bodyChoice {
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
                            switch vm.generatedGPTDay?.legChoice {
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
                        
                    }
                }
                VStack {
                    if(!vm.isAILoaded){
                        SwiftUIGIFPlayerView(gifName: "loadingGif", isShowProgressView: true)
                            .padding(.top, 175)
                            .scaleEffect(0.6)
                    }
                }
            }
            .animation(.easeInOut, value: vm.isAILoaded)
            
        }
    }
    
}
struct GlassyView: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Color.white.opacity(0.2)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
    }
}
    
    //struct MainAIPreview: PreviewProvider {
    //    static var previews: some View {
    //        ZStack {
    //            LinearGradient(colors: [.blue,.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
    //            MainAIView(isLoadedAI: .constant(true), currentGPTDay: GPTDay(clothingDesc: "Nice and toasty", headChoice: "hat", bodyChoice: "coat", legChoice: "sweatpants"))
    //        }
    //    }
    //}
    
