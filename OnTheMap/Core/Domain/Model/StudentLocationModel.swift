//
//  StudentLocationResponse.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation
import MapKit

struct StudentLocationModel: Codable, Identifiable {

  let id: String?
  let firstName: String?
  let lastName: String?
  let mapString: String?
  let mediaURL: String?
  let uniqueKey: String?
  let createdAt: String?
  let updatedAt: String?
  let latitude: Double?
  let longitude: Double?

  init(
    id: String?,
    firstName: String?,
    lastName: String?,
    latitude: Double?,
    longitude: Double?,
    mapString: String?,
    mediaURL: String?,
    uniqueKey: String?,
    createdAt: String?,
    updatedAt: String?
  ) {
    self.id = id
    self.firstName = firstName
    self.lastName = lastName
    self.latitude = latitude
    self.longitude = longitude
    self.mapString = mapString
    self.mediaURL = mediaURL
    self.uniqueKey = uniqueKey
    self.createdAt = createdAt
    self.updatedAt = updatedAt
  }

  func getCoordinate() -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
  }
}
