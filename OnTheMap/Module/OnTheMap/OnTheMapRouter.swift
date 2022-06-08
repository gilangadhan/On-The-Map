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
    let viewModel = OnTheMapViewModel(usecase)
    return OnTheMapView(viewModel: viewModel)
  }

}
