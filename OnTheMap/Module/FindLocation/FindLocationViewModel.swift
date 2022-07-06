//
//  FindLocationViewModel.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 23/06/22.
//

import Foundation
import Combine

class FindLocationViewModel: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let usecase: FindLocationUseCase

  @Published var errorMessage: String = ""
  @Published var showingAlert = false
  @Published var isLoading: Bool = false
  @Published var isSuccess: Bool = false
  @Published var location: String = ""
  @Published var longitude: Double = 0.0
  @Published var latitude: Double = 0.0
  @Published var link: String = ""

  init(_ usecae: FindLocationUseCase) {
    self.usecase = usecae
  }

  func findLocation() {
    isLoading = true
    if location.isEmpty {
      errorMessage = "Location is required!"
      showingAlert = true
      isLoading = false
    } else if link.isEmpty {
      errorMessage = "Link is required!"
      showingAlert = true
      isLoading = false
    } else {
      usecase.findLocations(by: location)
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
        self.longitude = result.longitude
        self.latitude = result.latitude
        self.isSuccess = true
      })
      .store(in: &cancellables)
    }
  }
}
