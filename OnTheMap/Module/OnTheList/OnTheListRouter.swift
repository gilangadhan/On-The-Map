//
//  OnTheListRouter.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import Foundation
import SwiftUI

class OnTheListRouter {

  func showView() -> some View {
    let usecase = Injection.init().provideGetStudentLocations()
    let viewModel = OnTheListViewModel(usecase)
    return OnTheListView(viewModel: viewModel)
  }

}
