//
//  OnTheMapView.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 08/06/22.
//

import SwiftUI
import MapKit

struct OnTheMapView: View {
  @State var isShowMap: Bool = false
  @State var outSiteClick: Bool = false
  @ObservedObject var viewModel: OnTheListViewModel

  @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: -6.9034495, longitude: 107.6431575),
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
    )
  }

  var emptyStudentLocations: some View {
    CustomEmptyView(
      image: "assetNoFavorite",
      title: "The student location is empty"
    )
  }

  var content: some View {
    Map(
      coordinateRegion: $region,
      showsUserLocation: true,
      annotationItems: viewModel.studentLocations
    ) { studentLocation in
      MapAnnotation(coordinate: studentLocation.getCoordinate()) {
        VStack {
          if let url = URL(string: studentLocation.mediaURL ?? "dicoding.com") {
            Link(destination: url) {
              VStack {
                Text("\(studentLocation.firstName ?? "") \(studentLocation.lastName ?? "")")
                Text("\(studentLocation.mapString ?? "")")
                Text("\(studentLocation.mediaURL ?? "")")
              }.background(Color.white)
                .opacity(isShowMap ? 1 : 0)
            }
          } else {
            VStack {
              Text("\(studentLocation.firstName ?? "") \(studentLocation.lastName ?? "")")
              Text("\(studentLocation.mapString ?? "")")
              Text("\(studentLocation.mediaURL ?? "URL Invalid")")
            }.background(Color.white)
              .opacity(isShowMap ? 1 : 0)
          }
          Button(action: {
            isShowMap = !isShowMap
          }, label: {
            VStack {
              Image(systemName: "mappin.circle.fill")
                .resizable()
                .frame(width: 30.0, height: 30.0)
              Circle()
                .frame(width: 8.0, height: 8.0)
            }
          }).foregroundColor(.red)
        }
      }
    }
  }
}
