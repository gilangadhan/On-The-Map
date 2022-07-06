//
//  OnTheListView.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import SwiftUI

struct OnTheListView: View {

  @ObservedObject var viewModel: OnTheListViewModel

  var body: some View {
    ZStack {
      if viewModel.isLoading {
        loadingIndicator
      } else if viewModel.isError {
        errorIndicator
      } else if viewModel.studentLocations.isEmpty {
        emptyStudentLocations
      } else {
        content
      }
    }.onAppear {
      if self.viewModel.studentLocations.count == 0 {
        self.viewModel.getStudentLocations()
      }
    }.navigationTitle(
      Text("List Student Location")
    )
  }
}

extension OnTheListView {

  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }

  var errorIndicator: some View {
      CustomEmptyView(
          image: "assetSearchNotFound",
          title: viewModel.errorMessage
      )
  }

  var emptyStudentLocations: some View {
      CustomEmptyView(
          image: "assetNoFavorite",
          title: "The student location is empty"
      )
  }

  var content: some View {
    ScrollView(.vertical, showsIndicators: false) {
      ForEach(
        self.viewModel.studentLocations,
        id: \.uniqueKey
      ) { result in
        ZStack {
          OnTheListItemRow(studentLocation: result)
        }.padding(8)
      }
    }
  }

}

struct OnTheListView_Previews: PreviewProvider {
  static var previews: some View {
    OnTheListRouter().showView()
  }
}
