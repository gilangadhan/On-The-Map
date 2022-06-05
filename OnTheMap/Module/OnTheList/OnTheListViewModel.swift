//
//  OnTheListViewMode.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation
import Combine

class OnTheListViewModel: ObservableObject {

  private var cancellables: Set<AnyCancellable> = []
  private let usecase: GetStudentLocationsUseCase

  @Published var studentLocations: [StudentLocationModel] = []
  @Published var errorMessage: String = ""
  @Published var isError: Bool = false
  @Published var isLoading: Bool = false

  init(_ usecae: GetStudentLocationsUseCase) {
    self.usecase = usecae
  }

  func getStudentLocations() {
    isLoading = true
    usecase.getStudentLocations()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.isError = true
            self.errorMessage = String(describing: completion)
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { result in
          self.studentLocations = result
        })
        .store(in: &cancellables)
  }

}
