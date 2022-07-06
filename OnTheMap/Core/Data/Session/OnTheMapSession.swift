//
//  Session.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 19/06/22.
//

import Combine
import Foundation

final class OnTheMapSession: ObservableObject {
  let state = "state"
  let key = "key"
  let firstNameKey = "first_name"
  let lastNameKey = "last_name"

  private init() {
    self.stateLogin = UserDefaults.standard.object(forKey: state) as? Bool ?? false
    self.userKey = UserDefaults.standard.object(forKey: key) as? String ?? ""
    self.firstName = UserDefaults.standard.object(forKey: firstNameKey) as? String ?? ""
    self.lastName = UserDefaults.standard.object(forKey: lastNameKey) as? String ?? ""

  }
  
  static let sharedInstance: OnTheMapSession = OnTheMapSession()
  
  @Published var stateLogin: Bool {
    didSet {
      UserDefaults.standard.set(stateLogin, forKey: state)
    }
  }
  
  @Published var userKey: String {
    didSet {
      UserDefaults.standard.set(userKey, forKey: key)
    }
  }

  @Published var firstName: String {
    didSet {
      UserDefaults.standard.set(firstName, forKey: firstNameKey)
    }
  }

  @Published var lastName: String {
    didSet {
      UserDefaults.standard.set(lastName, forKey: lastNameKey)
    }
  }

  func deteleAll() -> Bool {
    if let domain = Bundle.main.bundleIdentifier {
      UserDefaults.standard.removePersistentDomain(forName: domain)
      synchronize()
      return true
    } else { return false }
  }
  
  func synchronize() {
    UserDefaults.standard.synchronize()
  }
}
