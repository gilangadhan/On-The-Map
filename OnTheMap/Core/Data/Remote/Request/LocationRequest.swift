//
//  AddLocationRequest.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 06/07/22.
//

import Foundation

struct LocationRequest: Codable {
  let mapString: String
  let mediaURL: String
  let longitude: Double
  let latitude: Double
}
