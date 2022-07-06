//
//  AddLocationUseCase.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 06/07/22.
//

import Foundation
import Combine

protocol AddLocationUseCase {
  func addLocation(from location: AddLocationModel) -> AnyPublisher<Bool, Error>
}

class AddLocationInteractor: AddLocationUseCase {

  private let repository: OnTheMapRepositoryProtocol

  required init(repository: OnTheMapRepositoryProtocol) {
    self.repository = repository
  }

  func addLocation(from location: AddLocationModel) -> AnyPublisher<Bool, Error> {
    return repository.addLocation(from: location)
  }

}
