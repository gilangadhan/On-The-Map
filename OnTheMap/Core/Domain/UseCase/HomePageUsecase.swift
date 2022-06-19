//
//  HomePage.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 19/06/22.
//

import Foundation
import Combine

protocol HomePageUseCase {

  func deleteSession() -> AnyPublisher<Bool, Error>

}

class HomePageInteractor: HomePageUseCase {

  private let repository: OnTheMapRepositoryProtocol

  required init(
    repository: OnTheMapRepositoryProtocol
  ) {
    self.repository = repository
  }

  func deleteSession() -> AnyPublisher<Bool, Error> {
    return repository.deleteSession()
  }

}
