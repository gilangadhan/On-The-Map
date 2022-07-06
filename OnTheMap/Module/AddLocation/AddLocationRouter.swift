//
//  AddLocationRouter.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 06/07/22.
//

import Foundation

import SwiftUI

class AddLocationRouter {

  func showView(from location: AddLocationModel) -> some View {
    let usecase = Injection.init().provideAddLocation()
    let viewModel = AddLocationViewModel(usecase, location)
    return AddLocationView(viewModel: viewModel)
  }

}
