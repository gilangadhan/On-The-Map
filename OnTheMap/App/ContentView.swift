//
//  ContentView.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 05/06/22.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      TabView {
        OnTheListRouter().showView()
          .tabItem {
            Label("Map", systemImage: "globe.asia.australia")
          }
        OnTheListRouter().showView()
          .tabItem {
            Label("List", systemImage: "list.dash")
          }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
