//
//  GPTInputResponse.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/11/24.
//

import Foundation

struct GPTInputResponse: Encodable {
    let model: String
    let messages : [GPTMessage]
    let functions: [GPTFunction]
}

struct GPTMessage: Encodable {
    let role: String
    let content: String
}

struct GPTFunction: Encodable {
    let name: String
    let description: String
    let parameters: GPTParameters
}

struct GPTParameters: Encodable {
    let type: String
    let properties: [String: GPTFunctionProperty]?
    let required: [String]?
}

struct GPTFunctionProperty: Encodable {
    let type: String
    let description: String
}
