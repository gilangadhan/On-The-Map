//
//  SessionsResponses.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 19/06/22.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponses: Codable {
  let account: Account
  let session: Session
}

// MARK: - Account
struct Account: Codable {
  let registered: Bool
  let key: String
}

// MARK: - Session
struct Session: Codable {
  let id, expiration: String
}

// MARK: - LogoutResponse
struct LogoutResponses: Codable {
  let session: Session
}
