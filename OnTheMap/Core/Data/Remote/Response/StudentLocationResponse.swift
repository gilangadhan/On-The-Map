//
//  StudentLocationResponse.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation

struct StudentLocationResponses: Decodable {
  
  let results: [StudentLocationResponse]
  
}

struct StudentLocationResponse: Decodable {
  
  let firstName: String?
  let lastName: String?
  let longitude: Double?
  let latitude: Double?
  let mapString: String?
  let mediaURL: String?
  let uniqueKey: String?
  let objectId: String?
  let createdAt: String?
  let updatedAt: String?
  
}
