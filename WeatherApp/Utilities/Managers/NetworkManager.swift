//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Adam Mhal on 7/30/24.
//

import SwiftUI

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init () {}
    
    func generateCurrentWeatherURLRequest(httpMethod: HTTPMethod, lat: Double, lon: Double) async throws -> URLRequest {
        
        let currentWeatherUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(String(format: "%.2f",lat))&lon=\(String(format: "%.2f", lon))&appid=\(Secrets.weatherApiKey)&units=imperial"
        
        
        guard let url = URL(string: currentWeatherUrl) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod.rawValue
        
        return urlRequest
    }
    
    func generateWeatherForecastURLRequest(httpMethod: HTTPMethod, lat: Double, lon: Double) async throws -> URLRequest {
        
        let currentWeatherUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=\(String(format: "%.2f",lat))&lon=\(String(format: "%.2f", lon))&appid=\(Secrets.weatherApiKey)&units=imperial"
        
        
        guard let url = URL(string: currentWeatherUrl) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod.rawValue
        
        return urlRequest
    }
    
    func generateOpenAIURlRequest(httpMethod: HTTPMethod, message: String) async throws -> URLRequest {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else { throw URLError(.badURL) }
        
        var urlRequest = URLRequest(url: url)
        
        //Methods
        urlRequest.httpMethod = httpMethod.rawValue
        
        //Headers
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(Secrets.openAIApiKey)", forHTTPHeaderField: "Authorization")
                
        //Body
        let systemMessage = GPTMessage(role: "system", content: "You are an expert on deciding what clothes the user should wear based on the current weather that will be given to you. All weather information will be given in imperial format. Based on the weather you will need to respond with an appropriate headwear, body wear, and leg wear based on the options given to you. You will also need to respond with a short 2-4 sentence description that explains why you made your decision. The possible options to select for headwear is: [beanie, sunglasses, cap, scarf, nothing]. The possible options to select for body wear is: [coat, tshirt, longsleeve]. The possible options to select for leg wear is: [sweatpants, cargopants, jeans, shorts, winterpants]. Please provide your responses in this order: description, head wear option, body wear option, leg wear option. Reminder, these NEED TO BE IN THE ORDER: Description, Head Wear, Body Wear, and Leg Wear. Do not provide any other order. Additionally, never refer to yourself in first person. Do not use any pronouns, you are simply a system telling a user what is the best outfit to wear. Finally, the SYS POD paremeter refers to whether it is daytime or night time. d is day and n is night. Use this information accordingly.")
        let userMessage = GPTMessage(role: "user", content: message)
        
        let clothingDesc = GPTFunctionProperty(type: "string", description: "The short description on why you selected the respective clothing choices")
        let headChoice = GPTFunctionProperty(type: "string", description: "The one word selection for the head wear from the given choices based on the weather.")
        let bodyChoice = GPTFunctionProperty(type: "string", description: "The one word selection for the body wear from the given choices based on the weather.")
        let legChoice = GPTFunctionProperty(type: "string", description: "The one word selection for the leg wear from the given choices based on the weather.")
        
        let params: [String: GPTFunctionProperty] = [
            "clothingDesc": clothingDesc,
            "headChoice": headChoice,
            "bodyChoice": bodyChoice,
            "legChoice": legChoice
        ]
        
        let functionParams = GPTParameters(type: "object", properties: params, required: ["clothingDesc", "headChoice", "bodyChoice", "legChoice"])
        let function = GPTFunction(name: "get_clothes_and_desc", description: "Get the clothes and short desc for a given weather", parameters: functionParams)
        
        let payload = GPTInputResponse(model: "gpt-4o-mini", messages: [systemMessage, userMessage], functions: [function])
        
        let jsonData = try JSONEncoder().encode(payload)
        
        urlRequest.httpBody = jsonData
                
        return urlRequest
    }
    
    func generateCoordsURLRequest(httpMethod: HTTPMethod, location: String) async throws -> URLRequest {
        let coordsURL = "https://api.openweathermap.org/geo/1.0/direct?q=\(location)&appid=\(Secrets.weatherApiKey)"
        
        
        guard let url = URL(string: coordsURL) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod.rawValue
        
        return urlRequest
    }
    
    func getOpenAIResponse(currentWeather: String) async throws  -> (GPTDay?, Bool) {
        let urlRequest = try await generateOpenAIURlRequest(httpMethod: HTTPMethod.post, message: currentWeather)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
//        print(String(data: data, encoding: .utf8)!)
        
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(GPTOutputResponse.self, from: data)
            let args = result.choices[0].message.function_call.arguments
            guard let argData = args.data(using: .utf8) else { throw URLError(.badURL)}
            let tempDay = try decoder.decode(GPTDay.self, from: argData)
            return (tempDay, true)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return (nil, false)
        
    }
    
    func getWeatherForecast(lat: Double, lon: Double) async throws -> WeatherForecast? {
        let urlRequest = try await generateWeatherForecastURLRequest(httpMethod: HTTPMethod.get, lat: lat, lon: lon)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
                
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(WeatherForecast.self, from: data)
            return result
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return nil
    }
    
    func getCurrentWeather(lat: Double, lon: Double) async throws -> CurrentWeather? {
        let urlRequest = try await generateCurrentWeatherURLRequest(httpMethod: HTTPMethod.get, lat: lat, lon: lon)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
                
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(CurrentWeather.self, from: data)
            return result
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return nil
    }
    
    func getNewCoords(location: String) async throws -> [GeoCoords?] {
        let urlRequest = try await generateCoordsURLRequest(httpMethod: HTTPMethod.get, location: location)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
                        
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode([GeoCoords].self, from: data)
            return result
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return [nil]
    }
    
}




