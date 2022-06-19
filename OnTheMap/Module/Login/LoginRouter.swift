//
//  LoginRouter.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 19/06/22.
//

import SwiftUI

class LoginRouter {

  func showView() -> some View {
    let usecase = Injection.init().provideLogin()
    let viewModel = LoginViewModel(usecase)
    return LoginView(viewModel: viewModel)
  }

}
