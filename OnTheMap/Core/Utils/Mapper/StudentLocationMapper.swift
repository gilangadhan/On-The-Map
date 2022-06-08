//
//  StudentLocationMapper.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation
import MapKit

final class StudentLocationMapper {

  static func mapStudentLocationResponsesToEntities(
    input categoryResponses: [StudentLocationResponse]
  ) -> [StudentLocationModel] {
    return categoryResponses.map { result in

      return StudentLocationModel(
        id: result.objectId,
        firstName: result.firstName,
        lastName: result.lastName,
        coordinate: CLLocationCoordinate2D(latitude: result.latitude!, longitude: result.longitude!),
        mapString: result.mapString,
        mediaURL: result.mediaURL,
        uniqueKey: result.uniqueKey,
        createdAt: result.createdAt,
        updatedAt: result.updatedAt
      )
    }
  }
}
