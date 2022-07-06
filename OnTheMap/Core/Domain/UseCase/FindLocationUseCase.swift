//
//  FindLocationUseCase.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 06/07/22.
//

import Foundation
import Combine

protocol FindLocationUseCase {

  func findLocations(by location: String) -> AnyPublisher<DataLocationModel, Error>

}

class FindLocationInteractor: FindLocationUseCase {

  private let repository: OnTheMapRepositoryProtocol

  required init(repository: OnTheMapRepositoryProtocol) {
    self.repository = repository
  }

  func findLocations(by location: String) -> AnyPublisher<DataLocationModel, Error> {
    return repository.findLocation(by: location)
  }

}
