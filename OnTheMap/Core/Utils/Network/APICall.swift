//
//  APICall.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation

struct API {

  static let baseUrl = "https://onthemap-api.udacity.com/v1/"
  static let mapBaseUrl = "http://api.positionstack.com/v1/forward"
  static let APIKey = "2cdecf0e65ed01715a86afe12d352f33"

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {

  enum Request: Endpoint {
    case getStudentLocation
    case addStudentLocation
    case session
    case location
    case user

    public var url: String {
      switch self {
      case .getStudentLocation: return "\(API.baseUrl)StudentLocation?limit=100&order=-updatedAt"
      case .addStudentLocation: return "\(API.baseUrl)StudentLocation"
      case .session: return "\(API.baseUrl)session"
      case .location: return "\(API.mapBaseUrl)?access_key=\(API.APIKey)&limit=1&output=json&query="
      case .user: return "\(API.baseUrl)users/"
      }
    }
  }

}
