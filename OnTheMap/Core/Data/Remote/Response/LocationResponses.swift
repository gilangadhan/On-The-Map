//
//  LocationResponses.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 06/07/22.
//

import Foundation

// MARK: - Welcome
struct LocationResponse: Codable {
    let data: [DataLocationResponse]
}

// MARK: - Datum
struct DataLocationResponse: Codable {
    let latitude, longitude: Double?
    let type, name, number, postalCode: String?
    let street: String?
    let confidence: Int?
    let region, regionCode: String?
    let county: String?
    let locality: String?
    let administrativeArea: String?
    let neighbourhood, country, countryCode, continent: String?
    let label: String?

    enum CodingKeys: String, CodingKey {
        case latitude, longitude, type, name, number
        case postalCode = "postal_code"
        case street, confidence, region
        case regionCode = "region_code"
        case county, locality
        case administrativeArea = "administrative_area"
        case neighbourhood, country
        case countryCode = "country_code"
        case continent, label
    }
}
