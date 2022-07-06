//
//  HomePageViewModel.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 19/06/22.
//

import Foundation
import Combine
import SwiftUI

class HomePageViewModel: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let usecase: HomePageUseCase

  @Published var errorMessage: String = ""
  @Published var showingAlert = false
  @Published var isLoading: Bool = false
  @Published var isSuccess: Bool = false

  init(_ usecae: HomePageUseCase) {
    self.usecase = usecae
  }

  func deleteSession() {
    isLoading = true
    usecase.deleteSession()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.isSuccess = false
          self.errorMessage = error.localizedDescription
          self.showingAlert = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { result in
        if result {
          self.isSuccess = true
        } else {
          self.errorMessage = String(describing: "Failed to Logout!")
          self.showingAlert = true
        }
      })
      .store(in: &cancellables)
  }
}
