//
//  RemoteDataSource.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

protocol RemoteDataSourceProtocol: AnyObject {

  func getStudentLocations() -> AnyPublisher<[StudentLocationResponse], Error>
  func postSession(username: String, password: String) -> AnyPublisher<Bool, Error>
  func deleteSession() -> AnyPublisher<Bool, Error>

}

final class RemoteDataSource: NSObject {
  typealias RemoteInstance = (OnTheMapSession) -> RemoteDataSource
  fileprivate let session: OnTheMapSession

  private init(session: OnTheMapSession) {
    self.session = session
  }
  static let sharedInstance: RemoteInstance = { session in
    return RemoteDataSource(session: session)
  }

}

extension RemoteDataSource: RemoteDataSourceProtocol {

  func getStudentLocations() -> AnyPublisher<[StudentLocationResponse], Error> {

    return Future<[StudentLocationResponse], Error> { completion in
      if let url = URL(string: Endpoints.Request.studentLocation.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: StudentLocationResponses.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.results))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }

  func postSession(username: String, password: String) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      let url = URL(string: Endpoints.Request.session.url)
      var request = URLRequest(url: url!)
      request.httpMethod = "POST"
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")

      request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)

      let task = URLSession.shared.dataTask(with: request) { maybeData, maybeResponse, maybeError in
        if maybeError != nil {
          completion(.failure(URLError.addressUnreachable(url!)))
        } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {

          let range = 5..<data.count
          let newData = data.subdata(in: range)
          let decoder = JSONDecoder()
          print(data)
          do {
            let result = try decoder.decode(LoginResponses.self, from: newData)
            self.session.stateLogin = true
            self.session.userKey = result.account.key
            completion(.success(true))
          } catch {
            completion(.failure(URLError.invalidResponse))
          }
        } else {
          completion(.failure(URLError.invalidResponse))
        }
      }
      task.resume()
    }.eraseToAnyPublisher()
  }

  func deleteSession() -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in

      let url = URL(string: Endpoints.Request.session.url)
      var request = URLRequest(url: url!)
      request.httpMethod = "DELETE"
      var xsrfCookie: HTTPCookie?
      let sharedCookieStorage = HTTPCookieStorage.shared
      for cookie in sharedCookieStorage.cookies! where cookie.name == "XSRF-TOKEN" {
        xsrfCookie = cookie
      }
      if let xsrfCookie = xsrfCookie {
        request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
      }

      let task = URLSession.shared.dataTask(with: request) { maybeData, maybeResponse, maybeError in
        if maybeError != nil {
          completion(.failure(URLError.addressUnreachable(url!)))
        } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {

          let range = 5..<data.count
          let newData = data.subdata(in: range)
          let decoder = JSONDecoder()
          print(String(data: newData, encoding: .utf8)!)
          do {
            _ = try decoder.decode(LogoutResponses.self, from: newData)
            self.session.stateLogin = false
            self.session.userKey = ""
            completion(.success(true))
          } catch {
            completion(.failure(URLError.invalidResponse))
          }
        } else {
          completion(.failure(URLError.invalidResponse))
        }
      }
      task.resume()
    }.eraseToAnyPublisher()
  }
}
