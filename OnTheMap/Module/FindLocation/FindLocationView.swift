//
//  AddLocationView.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 23/06/22.
//

import Foundation
import SwiftUI

struct FindLocationView: View {
  @ObservedObject var viewModel: FindLocationViewModel

  var body: some View {
    ZStack {
      VStack {
        Text("Loading...")
        ActivityIndicator()
      }.opacity(viewModel.isLoading ? 1 : 0)

      VStack {
        HStack {
          Image(systemName: "map").foregroundColor(.gray)
          TextField("Enter your Location", text: $viewModel.location)
        }.padding()
          .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))

        HStack {
          Image(systemName: "link").foregroundColor(.gray)
          TextField("Enter your Link", text: $viewModel.link)
        }.padding()
          .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))

        Button("Find Location") {
          viewModel.findLocation()
        }.padding()
          .background(RoundedRectangle(cornerRadius: 15)
          .opacity(0.2))

        NavigationLink(
          destination: AddLocationRouter()
            .showView(from: AddLocationModel(
              mapString: viewModel.location,
              mediaURL: viewModel.link,
              longitude: viewModel.longitude,
              latitude: viewModel.latitude
            )),
          isActive: $viewModel.isSuccess
        ) {
          EmptyView()
        }
      }
    }.navigationTitle(
      Text("Find Location")
    ).padding()
      .alert(
        "\(viewModel.errorMessage)",
        isPresented: $viewModel.showingAlert
      ) {
        Button("OK", role: .cancel) { }
      }
  }
}
