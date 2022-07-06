//
//  LoginViewModel.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 19/06/22.
//

import Foundation
import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let usecase: LoginUsecase

  @Published var usernamse: String = ""
  @Published var password: String = ""
  @Published var showingAlert = false
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isSuccess: Bool = false

  init(_ usecae: LoginUsecase) {
    self.usecase = usecae
  }

  func postSession() {
    isLoading = true
    if !usernamse.isEmpty && !password.isEmpty {
      usecase.postSession(username: usernamse, password: password)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
              self.isSuccess = false
              self.errorMessage = error.localizedDescription
              self.showingAlert = true
            case .finished:
              self.isLoading = false
            }
          }, receiveValue: { result in
            if result {
              self.isSuccess = true
            } else {
              self.errorMessage = String(describing: "Failed to Login!")
              self.showingAlert = true
            }
          })
          .store(in: &cancellables)
    } else {
      errorMessage = "Please Check Username and Password!"
      showingAlert = true
      isLoading = false
    }
  }
}
