//
//  Model.swift
//  DZ KODE BackEnd
//
//  Created by Artem Elchev on 11.03.2024.
//

import Foundation

struct SensorData: Decodable {
    let sensorId: String
    let temperatureC: Double
}

struct PollResult: Decodable {
    let data: [SensorData]
}
