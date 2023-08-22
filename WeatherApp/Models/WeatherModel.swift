//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Daniyal Siddiqui on 2023-08-04.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let current: Current
    let location: LocationModel
}

// MARK: - Current
struct Current: Codable {
    let tempC, tempF: Double?
    let condition: WeatherCondition?
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
        case condition = "condition"
    }
}

struct LocationModel: Codable {
    let name: String?
}

struct WeatherCondition: Codable {
    let text, icon: String?
    let code: Int?
    
    enum CodingKeys: String, CodingKey {
        case text
        case icon
        case code
    }
}

struct WeatherLocalModel {
    let cityName, weatherCondition, temperature: String
    let imageCode: Int
}
