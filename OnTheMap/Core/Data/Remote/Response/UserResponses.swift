//
//  UserResponses.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 06/07/22.
//

import Foundation

// MARK: - Welcome
struct UserResponses: Codable {
    let user: UserResponse
}

// MARK: - User
struct UserResponse: Codable {
  let key: String
  let firstName: String
  let lastName: String
  enum CodingKeys: String, CodingKey {
    case lastName = "last_name"
    case firstName = "first_name"
    case key
  }
}
