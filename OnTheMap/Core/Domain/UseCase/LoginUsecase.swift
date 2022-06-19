//
//  LoginUsecase.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 19/06/22.
//

import Foundation
import Combine

protocol LoginUsecase {

  func postSession(username: String, password: String) -> AnyPublisher<Bool, Error>
}

class LoginInteractor: LoginUsecase {

  private let repository: OnTheMapRepositoryProtocol

  required init(
    repository: OnTheMapRepositoryProtocol
  ) {
    self.repository = repository
  }

  func postSession(username: String, password: String) -> AnyPublisher<Bool, Error> {
    return repository.postSession(username: username, password: password)
  }

}
