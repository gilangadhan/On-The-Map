//
//  LoginView.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 19/06/22.
//

import SwiftUI

struct LoginView: View {
  @ObservedObject var viewModel: LoginViewModel

  var body: some View {
    ZStack {
      VStack {
        Text("Loading...")
        ActivityIndicator()
      }.opacity(viewModel.isLoading ? 1 : 0)
      VStack {
        Text("Welcome!")
          .font(.largeTitle)
          .fontWeight(.semibold)
          .padding(.bottom, 20)

        TextField("Username", text: $viewModel.usernamse)
          .padding()
          .cornerRadius(5.0)
          .padding(.bottom, 20)

        SecureField("Password", text: $viewModel.password)
          .padding()
          .cornerRadius(5.0)
          .padding(.bottom, 20)

        Button("Login") {
          viewModel.postSession()
        }.alert(
          "\(viewModel.errorMessage)",
          isPresented: $viewModel.showingAlert
        ) {
          Button("OK", role: .cancel) { }
        }
        HStack {
          Text("Don't have an account?")
          Link("Sign Up", destination: URL(string: "https://www.google.com/url?q=https://www.udacity.com/account/auth%23!/signup&sa=D&source=editors&ust=1655646793500764&usg=AOvVaw0E7JoTz813_ChjFNLbV4Qq")!)
        }
      }
    }.navigationTitle(
      Text("On The Map Apps")
    )
  }
}
