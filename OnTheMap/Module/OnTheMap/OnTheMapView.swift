//
//  OnTheMapView.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 08/06/22.
//

import SwiftUI
import MapKit

struct OnTheMapView: View {

  @ObservedObject var viewModel: OnTheMapViewModel

  @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
    span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
  )

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
      Text("On The Map App")
    )
  }
}

extension OnTheMapView {

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
    ).offset(y: 80)
  }

  var emptyStudentLocations: some View {
    CustomEmptyView(
      image: "assetNoFavorite",
      title: "The student location is empty"
    ).offset(y: 80)
  }

  var content: some View {
    Map(
      coordinateRegion: $region,
      showsUserLocation: true,
      annotationItems: viewModel.studentLocations
    ) { studentLocation in
      MapAnnotation(coordinate: studentLocation.coordinate) {
        VStack {
          Group {
            Image(systemName: "mappin.circle.fill")
              .resizable()
              .frame(width: 30.0, height: 30.0)
            Circle()
              .frame(width: 8.0, height: 8.0)
            }.foregroundColor(.red)
          Text("\(studentLocation.firstName ?? "") \(studentLocation.lastName ?? "")")
        }.onTapGesture {
          print(studentLocation.mapString!)
        }
      }
    }
  }

}
