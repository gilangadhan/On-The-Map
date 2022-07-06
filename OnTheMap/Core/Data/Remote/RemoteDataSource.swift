//
//  RemoteDataSource.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation
import Combine
import SwiftUI

protocol RemoteDataSourceProtocol: AnyObject {

  func getStudentLocations() -> AnyPublisher<[StudentLocationResponse], Error>
  func findLocation(by location: String) -> AnyPublisher<DataLocationResponse, Error>
  func postSession(username: String, password: String) -> AnyPublisher<Bool, Error>
  func deleteSession() -> AnyPublisher<Bool, Error>
  func addLocation(from locationRequest: LocationRequest) -> AnyPublisher<Bool, Error>
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
  func findLocation(by location: String) -> AnyPublisher<DataLocationResponse, Error> {
    let newLocation = location.replacingOccurrences(of: " ", with: "%20")
    return Future<DataLocationResponse, Error> { completion in
      if let url = URL(string: "\(Endpoints.Request.location.url)\(newLocation)") {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { maybeData, maybeResponse, maybeError in
          if maybeError != nil {
            completion(.failure(URLError.addressUnreachable(url)))
          } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
            let decoder = JSONDecoder()
            do {
              let result = try decoder.decode(LocationResponse.self, from: data)
              print(result)
              if result.data.count == 0 {
                completion(.failure(URLError.invalidResponse))
              } else if result.data[0].latitude != nil, result.data[0].longitude != nil {
                completion(.success(result.data[0]))
              } else {
                completion(.failure(URLError.invalidResponse))
              }
            } catch {
              completion(.failure(URLError.invalidResponse))
            }
          } else {
            completion(.failure(URLError.invalidResponse))
          }
        }
        task.resume()
      } else {
        completion(.failure(URLError.invalidInput))
      }
    }.eraseToAnyPublisher()
  }

  func getStudentLocations() -> AnyPublisher<[StudentLocationResponse], Error> {

    return Future<[StudentLocationResponse], Error> { completion in
      if let url = URL(string: Endpoints.Request.getStudentLocation.url) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { maybeData, maybeResponse, maybeError in
          if maybeError != nil {
            completion(.failure(URLError.addressUnreachable(url)))
          } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
            let decoder = JSONDecoder()
            do {
              let result = try decoder.decode(StudentLocationResponses.self, from: data)
              completion(.success(result.results))
            } catch {
              completion(.failure(URLError.invalidResponse))
            }
          } else {
            completion(.failure(URLError.invalidResponse))
          }
        }
        task.resume()
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
          do {
            let result = try decoder.decode(LoginResponses.self, from: newData)
            let urlGetUser = URL(string: "\(Endpoints.Request.user.url)\(result.account.key)")

            let newTask = URLSession.shared.dataTask(with: URLRequest(url: urlGetUser!)) { maybeData, maybeResponse, maybeError in
              if maybeError != nil {
                completion(.failure(URLError.addressUnreachable(urlGetUser!)))
              } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {

                let range = 5..<data.count
                let newData = data.subdata(in: range)
                let decoder = JSONDecoder()
                do {
                  let result = try decoder.decode(UserResponse.self, from: newData)

                  DispatchQueue.main.async {
                    self.session.stateLogin = true
                    self.session.userKey = result.key
                    self.session.firstName = result.firstName
                    self.session.lastName = result.lastName
                    completion(.success(true))
                  }
                } catch {
                  completion(.failure(URLError.invalidResponse))
                }
              } else {
                completion(.failure(URLError.invalidResponse))
              }
            }
            newTask.resume()

          } catch {
            completion(.failure(URLError.invalidResponse))
          }
        } else {
          completion(.failure(URLError.credentialIncorrect))
        }
      }
      task.resume()
    }.receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }

  func addLocation(from locationRequest: LocationRequest) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      let url = URL(string: Endpoints.Request.addStudentLocation.url)
      var request = URLRequest(url: url!)

      request.httpMethod = "POST"
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")

      request.httpBody = "{\"uniqueKey\": \"\(self.session.userKey)\", \"firstName\": \"\(self.session.firstName)\", \"lastName\": \"\(self.session.lastName)\",\"mapString\": \"\(locationRequest.mapString)\", \"mediaURL\": \"\(locationRequest.mediaURL)\",\"latitude\": \(locationRequest.latitude), \"longitude\": \(locationRequest.longitude)}".data(using: .utf8)
      let task = URLSession.shared.dataTask(with: request) { maybeData, maybeResponse, maybeError in
        if maybeError != nil {
          completion(.failure(URLError.addressUnreachable(url!)))
        } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {

          let decoder = JSONDecoder()
          do {
            let result = try decoder.decode(AddLocationResponses.self, from: data)
            if !result.objectID.isEmpty {
              completion(.success(true))
            } else {
              completion(.failure(URLError.invalidResponse))
            }
          } catch {
            completion(.failure(URLError.invalidResponse))
          }
        } else {
          completion(.failure(URLError.invalidResponse))
        }
      }
      task.resume()
    }
      .eraseToAnyPublisher()
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
          do {
            _ = try decoder.decode(LogoutResponses.self, from: newData)
            DispatchQueue.main.async {
              self.session.stateLogin = false
              self.session.userKey = ""
              self.session.lastName = ""
              self.session.firstName = ""
              completion(.success(true))
            }
          } catch {
            completion(.failure(URLError.invalidResponse))
          }
        } else {
          completion(.failure(URLError.invalidResponse))
        }
      }
      task.resume()
    }.receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
}
