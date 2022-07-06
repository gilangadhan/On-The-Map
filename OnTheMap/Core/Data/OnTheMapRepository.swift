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
  func postSession(username: String, password: String) -> AnyPublisher<Bool, Error>
  func deleteSession() -> AnyPublisher<Bool, Error>
  func findLocation(by location: String) -> AnyPublisher<DataLocationModel, Error>
  func addLocation(from locationRequest: AddLocationModel) -> AnyPublisher<Bool, Error>

}

final class OnTheMapRepository: NSObject {
  
  typealias RepoInstance = (RemoteDataSource) -> OnTheMapRepository
  
  fileprivate let remote: RemoteDataSource
  
  private init(remote: RemoteDataSource) {
    self.remote = remote
  }
  
  static let sharedInstance: RepoInstance = { remoteRepo in
    return OnTheMapRepository(remote: remoteRepo)
  }
  
}

extension OnTheMapRepository: OnTheMapRepositoryProtocol {
  func addLocation(from locationRequest: AddLocationModel) -> AnyPublisher<Bool, Error> {
    let request = AddLocationMapper.mapAddLocationModelToRequest(input: locationRequest)
    return self.remote.addLocation(from: request)
  }

  func findLocation(by location: String) -> AnyPublisher<DataLocationModel, Error> {
    return self.remote.findLocation(by: location)
      .map { DataLocationMapper.mapDataLocationResponsesToEntities(input: $0) }
      .eraseToAnyPublisher()
  }

  func getStudentLocations() -> AnyPublisher<[StudentLocationModel], Error> {
    
    return self.remote.getStudentLocations()
      .map { StudentLocationMapper.mapStudentLocationResponsesToEntities(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func postSession(username: String, password: String) -> AnyPublisher<Bool, Error> {
    return remote.postSession(username: username, password: password)
  }
  
  func deleteSession() -> AnyPublisher<Bool, Error> {
    return remote.deleteSession()
  }
}
