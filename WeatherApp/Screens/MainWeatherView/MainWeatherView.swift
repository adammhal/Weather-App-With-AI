//
//  ContentView.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/7/24.
//

import SwiftUI
import CoreLocation
import TipKit

struct MainWeatherView: View {
    
    //add alerts and errors when things go wrong
    @StateObject private var vm = MainWeatherViewModel()
    @State var animateGradient = false
    let shakeNightTip = ShakeForNightTip()
    let colors = [Color.teal,Color.purple]
    @Namespace var animNamespace
    
    
    var body: some View {
        
        ZStack {
            BackgroundView(isNight: $vm.isNight)
            VStack {
                //add button to pull up moon phases
                //auto start night time if it is night
                if !vm.isShowingCityView {
                    CityTextView(cityNamespace: animNamespace, cityName: vm.combinedName,
                                 isNight: vm.isNight)
                    .onTapGesture {
                        withAnimation {
                            vm.isShowingCityView = true
                        }
                    }
                }
                
                MainWeatherStatusView(
                    imageName: vm.isNight ? vm.currentDayNight?.nightWeather?.weather.first!.main.turnIntoIcon(isNight: true) ?? "questionmark.circle.fill" : vm.currentWeather?.weather.first?.main.turnIntoIcon(isNight: vm.noDayWeather) ?? "questionmark.circle.fill",
                    temperature: Int(round(vm.isNight ? vm.currentDayNight?.morningWeather?.main.temp ?? vm.currentDayNight?.nightWeather?.main.temp ?? 011521: vm.currentDayNight?.nightWeather?.main.temp ?? 011521)),
                    count: vm.count,
                    animNamespace: animNamespace,
                    dayOfWeek: vm.currentDayNight?.day ?? "",
                    isNight: vm.isNight)
                .onTapGesture {
                    withAnimation {
                        vm.selectedWeather = vm.isNight ? vm.currentDayNight!.nightWeather : vm.currentDayNight?.morningWeather ?? vm.currentDayNight!.nightWeather
                        vm.isShowingDetailMain = true
                        vm.isShowingDetail = true
                        vm.isShowingDetailFinished = false
                    }
                }
                TipView(shakeNightTip)
                    .tipBackground(.darkBlue.opacity(0.3))
                    .frame(width: 300, height: 100)
                ZStack {
                    Rectangle()
                        .frame(width: 350, height: 150)
                        .clipShape(.rect(cornerRadius: 20))
                        .foregroundStyle(vm.isNight ? Color.darkBlue : Color.lightBlue)
                        .opacity(0.7)
                    
                    HStack (spacing: 15){
                        ForEach(vm.weatherDayNight.prefix(5), id: \.id){ entireDay in
                            withAnimation {
                                WeatherDayView(dayOfWeek: entireDay.day,
                                               imageName: vm.isNight ? entireDay.nightWeather.weather.first!.main.turnIntoIcon(isNight: true) : entireDay.morningWeather.weather.first!.main.turnIntoIcon(isNight: false),
                                               temperature: Int(round(vm.isNight ? entireDay.nightWeather.main.temp : entireDay.morningWeather.main.temp)),
                                               animNamespace: animNamespace,
                                               isNight: vm.isNight)
                                
                            }
                            .onTapGesture {
                                withAnimation {
                                    vm.selectedWeather = vm.isNight ? entireDay.nightWeather : entireDay.morningWeather
                                    vm.isShowingDetail = true
                                    vm.isShowingDetailFinished = false
                                }
                            }
                            .padding([.leading, .trailing], 5)
                        }
                        .transition(.scale)
                    }
                    .animation(.easeInOut, value: vm.count)
                    .frame(height:200)
                }
                Spacer()
                    .onShakeGesture {
                        shakeNightTip.invalidate(reason: .actionPerformed)
                        withAnimation {
                            vm.count += 1
                            vm.isNight.toggle()
                            vm.isAILoaded = false
                            vm.generatedGPTDay = nil
                            
                        }
                    }
                HStack {
                    Image(systemName: "sparkles")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(.bottom,30)
                        .symbolEffect(.bounce, value: vm.count)
                        .symbolEffect(.pulse, options: .repeating)
                        .onTapGesture {
                            withAnimation {
                                vm.isShowingAIView = true
                                Task {
                                    if vm.generatedGPTDay == nil {
                                        await vm.getGPTDay()
                                    }
                                }
                            }
                        }
                        .onLongPressGesture {
                            vm.isAILoaded = false
                            vm.generatedGPTDay = nil
                        }
                }
                .foregroundStyle(
                    .linearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
                
                
            }
            .disabled(!vm.isShowingDetailFinished || vm.isShowingCityView)
            .blur(radius: vm.isShowingDetail || vm.isShowingCityView ? 20 : 0)
            if vm.isShowingDetail {
                withAnimation {
                    WeatherCardView(imageName: vm.selectedWeather!.weather.first!.main.turnIntoIcon(isNight: vm.isShowingDetailMain ? vm.noDayWeather : vm.isNight),
                                    weather: vm.selectedWeather!,
                                    dayOfWeek: vm.dateFormat(vm.selectedWeather!.dt_txt),
                                    animNamespace: animNamespace,
                                    isShowingDetail: $vm.isShowingDetail,
                                    isShowingDetailFinished: $vm.isShowingDetailFinished,
                                    isShowingDetailMain: $vm.isShowingDetailMain,
                                    isNight: vm.isNight)
                }
            }
            if vm.isShowingCityView {
                withAnimation {
                    ChangeCityView(cityNamespace: animNamespace, ogName: vm.combinedName, vm: vm)
                }
            }
            if !vm.isLoaded {
                LoadingView(isNight: $vm.isNight)
            }
        }.task {
            do {
                try await vm.getCoord()
            } catch {
                print("location error")
            }
            await vm.getCurrentWeather()
            await vm.getWeatherForecast()
        }.sheet(isPresented: $vm.isShowingAIView, content: {
            ZStack {
                AnimatedBGView(animateGradient: $animateGradient, colors: colors)
                MainAIView(vm: vm)
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.significantTimeChangeNotification), perform: { _ in
            vm.isAILoaded = false
            vm.generatedGPTDay = nil
        })
        
    }
    
    
    
}

#Preview {
    MainWeatherView()
        .task {
            //            try? Tips.resetDatastore()
            try? Tips.configure([
                .datastoreLocation(.applicationDefault)])
        }
}


