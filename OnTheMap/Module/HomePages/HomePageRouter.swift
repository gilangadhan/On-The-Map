//
//  HomePageRouter.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 19/06/22.
//

import SwiftUI

class HomePageRouter {

  func showView() -> some View {
    let usecase = Injection.init().provideHomePage()
    let viewModel = HomePageViewModel(usecase)
    return HomePageView(viewModel: viewModel)
  }

}
