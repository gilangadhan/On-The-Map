//
//  OnTheListUseCase.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation
import Combine

protocol GetStudentLocationsUseCase {

  func getStudentLocations() -> AnyPublisher<[StudentLocationModel], Error>

}

class GetStudentLocationsInteractor: GetStudentLocationsUseCase {

  private let repository: OnTheMapRepositoryProtocol

  required init(repository: OnTheMapRepositoryProtocol) {
    self.repository = repository
  }

  func getStudentLocations() -> AnyPublisher<[StudentLocationModel], Error> {
    return repository.getStudentLocations()
  }

}
