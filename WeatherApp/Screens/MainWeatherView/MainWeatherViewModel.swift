//
//  MainWeatherViewModel.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/30/24.
//

import CoreLocation
import Observation


@MainActor
@Observable
final class MainWeatherViewModel: ObservableObject {
    var count = 0
    
    var isNight = false
    var weatherDays: [dayWeather]?
    var weatherNights: [dayWeather]?
    var weatherDayNight: [WeatherDay] = []
    var currentWeather: CurrentWeather?
    var currentDayNight: CurrentDay?
    var weatherForecast: WeatherForecast?
    var selectedWeather: dayWeather?
    var generatedGPTDay: GPTDay?
    var currGeoCoords: [GeoCoords?] = []
    
    var currentLon: Double = 0
    var currentLat: Double = 0
    
    var currCityName = ""
    var currCountryName = ""
    var combinedName = ""
    
    var isShowingDetail = false
    var isShowingDetailFinished = true
    var isLoaded = false
    var noDayWeather = false
    var isShowingDetailMain = false
    var isShowingAIView = false
    var isAILoaded = false
    var isShowingCityView = false
    var locationFound = false
    
    var alertItem: AlertItem?
    
    let today = Date.now
    var todayTxt = ""
    
    var lm = LocationManager()
    var network = NetworkManager.shared
    
    
    func getCoord() async throws {
        await lm.checkLocationAuthorization()
        guard let lat = lm.lastKnownLocation?.latitude else {
            throw URLError(.badServerResponse)
        }
        guard let lon = lm.lastKnownLocation?.longitude else {
            throw URLError(.badServerResponse)
        }
        currentLat = lat
        currentLon = lon
    }
    
    func getWeatherForecast() async {
        do {
            try await weatherForecast = network.getWeatherForecast(lat: currentLat, lon: currentLon)
            guard let weatherDays = weatherForecast?.list else {
                return
            }
            self.weatherDays = weatherDays
            self.weatherNights = weatherDays
            cleanWeatherDays()
        } catch {
            print("There was an unknown error")
        }
    }
    
    func getGPTDay() async {
        do {
            let encoder = JSONEncoder()
            let currWeather: String = String(data: try encoder.encode(isNight ? currentDayNight!.nightWeather : currentDayNight?.morningWeather ?? currentDayNight!.nightWeather), encoding: .utf8)!
            try await (self.generatedGPTDay, isAILoaded) = network.getOpenAIResponse(currentWeather: currWeather)
        } catch {
            print("There was an unknown error")
        }
    }
    
    func getCurrentWeather() async {
        do {
            try await currentWeather = network.getCurrentWeather(lat: currentLat, lon: currentLon)
            currCityName = currentWeather!.name
            currCountryName = currentWeather!.sys.country
            combinedName = currCityName + ", " + currCountryName
        } catch {
            print("There was an unknown error")
        }
    }
    
    func getCurrentCoords() async throws {
        try await currGeoCoords = network.getNewCoords(location: self.combinedName.replacingOccurrences(of: ", ", with: ","))
        if currGeoCoords.isEmpty || currGeoCoords.first == nil {
            throw URLError(.unknown)
        }
        currentLat = currGeoCoords.last!!.lat
        currentLon = currGeoCoords.last!!.lon
        generatedGPTDay = nil
        isAILoaded = false
        isLoaded = false
        weatherDayNight = []
        await getCurrentWeather()
        await getWeatherForecast()
    }
    
    func cleanWeatherDays() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        todayTxt = dateFormatter.string(from: today)
        
        weatherDays!.removeAll(where: {$0.sys.pod == "n"})
        weatherNights!.removeAll(where: {$0.sys.pod == "d"})
        
        weatherNights!.insert(weatherDays!.first!, at: 0)
        
        var priorDay = today.formatted(Date.FormatStyle().weekday(.abbreviated)).uppercased()
        
        let currWeatherDay = dayWeather(dt: currentWeather!.dt, main: currentWeather!.main, weather: currentWeather!.weather, cloud: currentWeather!.clouds, wind: currentWeather!.wind, visibility: currentWeather!.visibility, pop: weatherDays!.first!.pop, rain: currentWeather!.rain, sys: weatherDays!.first!.sys, dt_txt: todayTxt)
        
        for i in 0..<self.weatherNights!.count{
            let currDay = dateFormat(weatherNights![i].dt_txt)
            if currDay == priorDay && i != 0 {
                weatherNights![i-1] = MockData.invalidDay
            }
            priorDay = currDay
        }
        priorDay = today.formatted(Date.FormatStyle().weekday(.abbreviated)).uppercased()
        for i in 0..<self.weatherDays!.count {
            let currDay = dateFormat(weatherDays![i].dt_txt)
            if currDay == priorDay {
                weatherDays![i] = MockData.invalidDay
            }
            priorDay = currDay
        }
        count+=1
        let today = today.formatted(Date.FormatStyle().weekday(.abbreviated)).uppercased()
        weatherDays!.removeAll(where: {$0.dt == -1})
        weatherNights!.removeAll(where: {$0.dt == -1})
        if(today == dateFormat(weatherNights!.first!.dt_txt)){
            currentDayNight = CurrentDay(day: today, morningWeather: currWeatherDay, nightWeather: weatherNights!.first)
            weatherNights!.remove(at: 0)
        } else {
            noDayWeather = true
            currentDayNight = CurrentDay(day: today, morningWeather: nil, nightWeather: currWeatherDay)
        }
        
        let n = min(weatherDays!.count, weatherNights!.count)
        
        for i in 0..<n {
            let day = dateFormat(weatherDays![i].dt_txt)
            self.weatherDayNight.append(WeatherDay(day: day,
                                                   morningWeather: weatherDays![i],
                                                   nightWeather: weatherNights![i]))
        }
        self.isLoaded = true
    }
    
    func dateFormat(_ date: String) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH-mm-ss"
        format.locale = Locale(identifier: "en_US")
        format.isLenient = true
        let dateFromString = format.date(from: date)
        
        guard let x: String = (dateFromString?.formatted(
            Date.FormatStyle()
                .weekday(.abbreviated)
        )) else {
            return "AIA"
        }
        
        return x.uppercased()
        
        
        
        
    }
    
    
    
    
}

