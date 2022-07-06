//
//  DataLocationMapper.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 06/07/22.
//

import Foundation

final class DataLocationMapper {

  static func mapDataLocationResponsesToEntities(
    input dataResponse: DataLocationResponse
  ) -> DataLocationModel {
      return DataLocationModel(
        latitude: dataResponse.latitude ?? 0.0,
        longitude: dataResponse.longitude ?? 0.0,
        type: dataResponse.type ?? "" ,
        name: dataResponse.name ?? "",
        number: dataResponse.number ?? "",
        postalCode: dataResponse.postalCode ??  "",
        street: dataResponse.street ??  "",
        confidence: dataResponse.confidence ?? 0,
        region: dataResponse.region ??  "",
        regionCode: dataResponse.regionCode ??  "",
        county: dataResponse.county ?? "",
        locality: dataResponse.locality ??  "",
        administrativeArea: dataResponse.administrativeArea ??  "",
        neighbourhood: dataResponse.neighbourhood ??  "",
        country: dataResponse.county ??  "",
        countryCode: dataResponse.countryCode ?? "",
        continent: dataResponse.continent ??  "",
        label: dataResponse.label ??  ""
      )
  }
}

final class AddLocationMapper {

  static func mapAddLocationModelToRequest(
    input model: AddLocationModel
  ) -> LocationRequest {
      return LocationRequest(
        mapString: model.mapString,
        mediaURL: model.mediaURL,
        longitude: model.longitude,
        latitude: model.latitude
      )
  }
}
