//
//  Injection.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation

final class Injection: NSObject {
  func provideSession() -> OnTheMapSession {
    return OnTheMapSession.sharedInstance
  }

  private func provideRepository() -> OnTheMapRepositoryProtocol {
    let session = provideSession()
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance(session)
    return OnTheMapRepository.sharedInstance(remote)
  }

  func provideGetStudentLocations() -> GetStudentLocationsUseCase {
    let repository = provideRepository()
    return GetStudentLocationsInteractor(repository: repository)
  }

  func provideLogin() -> LoginUsecase {
    let repository = provideRepository()
    return LoginInteractor(repository: repository)
  }

  func provideHomePage() -> HomePageUseCase {
    let repository = provideRepository()
    return HomePageInteractor(repository: repository)
  }
}
