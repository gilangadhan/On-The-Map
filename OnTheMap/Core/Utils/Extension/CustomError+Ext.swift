//
//  CustomError+Ext.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation

enum URLError: LocalizedError {

  case invalidResponse
  case noInternet
  case logoutFailed
  case addressUnreachable(URL)
  case credentialIncorrect
  case invalidInput

  var errorDescription: String? {
    switch self {
    case .invalidResponse: return "The server responded with garbage."
    case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
    case .logoutFailed: return "Can't remove cache from login."
    case .noInternet: return "The Internet connection is offline, please try again later."
    case .credentialIncorrect: return "The credentials were incorrect, please check your email or/and your password."
    case .invalidInput: return "Please not use special character."
    }
  }

}

enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed

  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }

}
