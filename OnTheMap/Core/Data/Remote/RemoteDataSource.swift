//
//  RemoteDataSource.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {

  func getStudentLocations() -> AnyPublisher<[StudentLocationResponse], Error>

}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {

  func getStudentLocations() -> AnyPublisher<[StudentLocationResponse], Error> {

    return Future<[StudentLocationResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.studentLocation.url) {
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

}
