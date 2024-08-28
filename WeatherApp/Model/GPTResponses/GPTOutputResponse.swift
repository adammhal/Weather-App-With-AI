//
//  GPTOutputResponse.swift
//  WeatherApp
//
//  Created by Adam Mhal on 8/11/24.
//

import Foundation

struct GPTOutputResponse: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [GPTChoices]
    let usage: GPTUsage
    let system_fingerprint: String
}

struct GPTChoices: Decodable {
    let index: Int
    let message: GPTOutputMessage
    let logprobs: String?
    let finish_reason: String
}

struct GPTOutputMessage: Decodable {
    let role: String
    let content: String?
    let function_call: GPTOutputFunction
    let refusal: String?
}

struct GPTOutputFunction: Decodable {
    let name: String
    let arguments: String
}

struct GPTUsage: Decodable {
    let prompt_tokens: Int
    let completion_tokens: Int
    let total_tokens: Int
}

