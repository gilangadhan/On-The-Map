//
//  StudentLocationMapper.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation

final class StudentLocationMapper {

  static func mapStudentLocationResponsesToEntities(
    input categoryResponses: [StudentLocationResponse]
  ) -> [StudentLocationModel] {
    return categoryResponses.map { result in
      return StudentLocationModel(
        firstName: result.firstName,
        lastName: result.lastName,
        longitude: result.longitude,
        latitude: result.latitude,
        mapString: result.mapString,
        mediaURL: result.mediaURL,
        uniqueKey: result.uniqueKey,
        objectId: result.objectId,
        createdAt: result.createdAt,
        updatedAt: result.updatedAt
      )
    }
  }
}
