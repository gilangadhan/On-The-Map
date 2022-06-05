//
//  OnTheMapRepository.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation
import Combine

protocol OnTheMapRepositoryProtocol {

  func getStudentLocations() -> AnyPublisher<[StudentLocationModel], Error>

}

final class OnTheMapRepository: NSObject {

  typealias MealInstance = (RemoteDataSource) -> OnTheMapRepository

  fileprivate let remote: RemoteDataSource

  private init(remote: RemoteDataSource) {
    self.remote = remote
  }

  static let sharedInstance: MealInstance = { remoteRepo in
    return OnTheMapRepository(remote: remoteRepo)
  }

}

extension OnTheMapRepository: OnTheMapRepositoryProtocol {

  func getStudentLocations() -> AnyPublisher<[StudentLocationModel], Error> {

    return self.remote.getStudentLocations()
      .map { StudentLocationMapper.mapStudentLocationResponsesToEntities(input: $0) }
      .eraseToAnyPublisher()
  }
}
