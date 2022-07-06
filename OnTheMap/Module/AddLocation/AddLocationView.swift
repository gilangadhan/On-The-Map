//
//  AddLocationView.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 06/07/22.
//

import Foundation
import SwiftUI
import MapKit

struct AddLocationView: View {
  @ObservedObject var viewModel: AddLocationViewModel
  @State private var region = MKCoordinateRegion()

  @State var markers: [Marker] = []

  var body: some View {
    ZStack {
      VStack {
        Text("Loading...")
        ActivityIndicator()
      }.opacity(viewModel.isLoading ? 1 : 0)

      VStack {
        Map(
          coordinateRegion: $region,
          showsUserLocation: true,
          annotationItems: markers
        ) { marker in
          marker.location
        }.edgesIgnoringSafeArea(.all)
          .onAppear {
            setRegion()
          }
        Button("Add Location") {
          viewModel.addLocation()
        }.padding()
      }

      NavigationLink(
        destination: HomePageRouter()
          .showView()
          .transition(.opacity)
          .navigationBarHidden(true),
        isActive: $viewModel.isSuccess
      ) {
        EmptyView()
      }

    }.navigationTitle(
      Text("Find Location")
    ).alert(
        "\(viewModel.errorMessage)",
        isPresented: $viewModel.showingAlert
      ) {
        Button("OK", role: .cancel) { }
      }
  }

  private func setRegion() {
    let beforeLocation = CLLocationCoordinate2D(latitude: viewModel.location.latitude, longitude: viewModel.location.longitude)

    markers = [Marker(location: MapMarker(coordinate: beforeLocation, tint: .red))]
    region = MKCoordinateRegion(
      center: beforeLocation,
      span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
  }
}

struct Marker: Identifiable {
    let id = UUID()
    var location: MapMarker
}
