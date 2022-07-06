//
//  AddLocationViewModel.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 06/07/22.
//

import Foundation
import Combine

class AddLocationViewModel: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let usecase: AddLocationUseCase
  let location: AddLocationModel

  @Published var errorMessage: String = ""
  @Published var showingAlert = false
  @Published var isLoading: Bool = false
  @Published var isSuccess: Bool = false

  init(_ usecae: AddLocationUseCase, _ location: AddLocationModel) {
    self.usecase = usecae
    self.location = location
  }

  func addLocation() {
    isLoading = true
    usecase.addLocation(from: location)
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
          self.errorMessage = String(describing: "Failed to Add Data!")
          self.showingAlert = true
        }
      })
      .store(in: &cancellables)
  }
}
