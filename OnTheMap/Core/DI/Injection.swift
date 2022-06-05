//
//  Injection.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation

final class Injection: NSObject {

  private func provideRepository() -> OnTheMapRepositoryProtocol {
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    return OnTheMapRepository.sharedInstance(remote)
  }

  func provideGetStudentLocations() -> GetStudentLocationsUseCase {
    let repository = provideRepository()
    return GetStudentLocationsInteractor(repository: repository)
  }

}
