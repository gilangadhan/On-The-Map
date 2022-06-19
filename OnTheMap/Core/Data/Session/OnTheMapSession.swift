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
  
  private init() {
    self.stateLogin = UserDefaults.standard.object(forKey: state) as? Bool ?? false
    self.userKey = UserDefaults.standard.object(forKey: key) as? String ?? ""
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
  
  static func deteleAll() -> Bool {
    if let domain = Bundle.main.bundleIdentifier {
      UserDefaults.standard.removePersistentDomain(forName: domain)
      synchronize()
      return true
    } else { return false }
  }
  
  static func synchronize() {
    UserDefaults.standard.synchronize()
  }
}
