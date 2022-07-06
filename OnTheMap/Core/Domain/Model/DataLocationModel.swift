//
//  DataLocationModel.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 06/07/22.
//

import Foundation

struct DataLocationModel: Codable {
  var latitude: Double
  var longitude: Double
  var type: String
  var name: String
  var number: String
  var postalCode: String
  var street: String
  var confidence: Int
  var region: String
  var regionCode: String
  var county: String
  var locality: String
  var administrativeArea: String
  var neighbourhood: String
  var country: String
  var countryCode: String
  var continent: String
  var label: String 
}
