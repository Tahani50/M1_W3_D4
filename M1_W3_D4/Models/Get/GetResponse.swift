//
//  WeatherResponse.swift
//  M1_W3_D4
//
//  Created by Taibah Valley Academy on 3/19/25.
//


import Foundation

struct GetResponse: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

