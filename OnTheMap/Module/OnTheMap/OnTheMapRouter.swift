//
//  OnTheMapRouter.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 08/06/22.
//

import SwiftUI

class OnTheMapRouter {

  func showView() -> some View {
    let usecase = Injection.init().provideGetStudentLocations()
    let viewModel = OnTheListViewModel(usecase)
    return OnTheMapView(viewModel: viewModel)
  }

}
