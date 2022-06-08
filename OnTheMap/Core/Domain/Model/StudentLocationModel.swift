//
//  StudentLocationResponse.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation
import MapKit

struct StudentLocationModel: Identifiable {
  let id: String?
  let firstName: String?
  let lastName: String?
  let coordinate: CLLocationCoordinate2D
  let mapString: String?
  let mediaURL: String?
  let uniqueKey: String?
  let createdAt: String?
  let updatedAt: String?

}
