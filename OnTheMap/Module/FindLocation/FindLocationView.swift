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
          TextFieldWithCheck("Enter your Location", text: $viewModel.location, allowed: .alphanumerics)
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

// here is the custom TextField itself
struct TextFieldWithCheck: View {

    let label: LocalizedStringKey
    @Binding var text: String
    let limit: Int
    let allowed: CharacterSet

    init(_ label: LocalizedStringKey, text: Binding<String>, limit: Int = Int.max, allowed: CharacterSet = .alphanumerics) {
        self.label = label
        self._text = Binding(projectedValue: text)
        self.limit = limit
        self.allowed = allowed
    }

    var body: some View {
      TextField(label, text: $text)
        .onChange(of: text) { _ in
          text = String(text.prefix(limit).unicodeScalars.filter(allowed.contains))
      }
    }
}
