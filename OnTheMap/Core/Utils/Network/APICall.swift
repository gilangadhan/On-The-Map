//
//  APICall.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation

struct API {

  static let baseUrl = "https://onthemap-api.udacity.com/v1/"

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {

  enum Gets: Endpoint {
    case studentLocation

    public var url: String {
      switch self {
      case .studentLocation: return "\(API.baseUrl)StudentLocation?limit=100&order=-updatedAt"
      }
    }
  }

}
