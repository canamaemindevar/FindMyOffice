//
//  OfficeResponse.swift
//  FindMyOffice
//
//  Created by Emincan on 4.08.2022.
//

import Foundation

// MARK: - OfficeResponseElement
struct OfficeResponseElement: Codable {
    let address, capacity: String?
    let id: Int?
    let image: String?
    let images: [String]?
    let location: Location?
    let name: String?
    let rooms: Int?
    let space: String?
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Double?
}

typealias OfficeResponse = [OfficeResponseElement]
